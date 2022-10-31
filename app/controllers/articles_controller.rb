# frozen_string_literal: true

require 'net/http'
require 'json'

# Geofactory is not actually used in the app but I felt we should create the user location record anyway to enable further integration.
GEOFACTORY = RGeo::ActiveRecord::SpatialFactoryStore.instance.factory(geo_type: 'st_point')

##
# Controller Class for handling endpoints to "/articles"
class ArticlesController < ApplicationController
  before_action :set_article, only: %i[show edit update destroy]
  before_action :get_page_data, only: %i[index], unless: -> { Rails.env="test" }

  # GET /articles or /articles.json
  def index
    @articles = Article.all
  end

  # GET /articles/1 or /articles/1.json
  def show; end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # POST /articles or /articles.json
  def create
    @article = Article.new(article_params)

    respond_to do |format|
      if @article.save
        format.html { redirect_to article_url(@article), notice: "Article was successfully created." }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1 or /articles/1.json
  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to article_url(@article), notice: "Article was successfully updated." }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  # Fetches the JSON from Olio server and posts required records
  def olio_object
    url = 'https://s3-eu-west-1.amazonaws.com/olio-staging-images/developer/test-articles-v4.json'
    uri = URI(url)
    response = Net::HTTP.get(uri)
    JSON.parse(response)
  end

  # Set as before_action on index to get latest data while persisting local likes if data is updated on page reload.
  # Clunky and lacks error handling.
  def get_page_data
    olio_object.each do |article|
      puts "adding article user..."
      User.find_or_create_by(id: article['user']['id']) do |u|
        u.first_name     = article['user']['first_name']
        u.current_avatar = article['user']['current_avatar']['small']
        u.roles          = article['user']['roles']
        u.rating         = article['user']['rating']
        u.verifications  = article['user']['verifications']
        u.updated_at     = Time.now
      end

      puts 'updating articles...'
      @article = Article.find_or_create_by(id: article['id']) do |a|
                  a.id                = article['id']
                  a.title             = article['title']
                  a.description       = article['description']
                  a.section           = article['section']
                  a.collection_notes  = article['collection_notes']
                  # Opted to select just one image for faster re-rendering
                  a.image             = article['images'][0]['files']['large']
                  a.user_id           = article['user']['id']
                  a.is_owner          = article['is_owner']
                  a.updated_at        = Time.now
                end

      if @article.new_record?
        puts 'adding article location...'
        article['location'] && Address.find_or_create_by(locatable_id: article['id']) do |l|
            l.town           = article['location']['town']
            l.country        = article['location']['country']
            l.distance       = article['location']['distance']
            l.locatable_id   = article['id']
            l.locatable_type = 'Article'
            l.created_at     = Time.now
        end

        puts 'adding article reactions...'
        Reaction.find_or_create_by(article_id: article['id']) do |r|
          r.likes       = article['reactions']['likes']
          r.by_user     = article['reactions']['by_user']
          r.views       = article['reactions']['views']
          r.impressions = article['reactions']['impressions']
          r.article_id  = article['id']
          r.updated_at  = Time.now
        end

        # Closer inspection of the records in the view raised questions about "is_owner": false and user "roles"
        # User Address records are updated or created but never implemented in the view.
        puts 'adding user location...'
        Address.find_or_create_by(locatable_id: article['user']['id']) do |l|
          l.location       = GEOFACTORY.point(article['user']['location']['longitude'], article['user']['location']['latitude'])
          l.locatable_id   = article['user']['id']
          l.locatable_type = 'User'
          l.updated_at     = Time.now
        end
      end
    end
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_article
    @article = Article.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def article_params
    params.require(:article).permit(:title, :description, :section, :location, :value, :status, :reactions, :is_owner, :collection_notes, :images)
  end
end
