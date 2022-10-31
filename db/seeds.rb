# frozen_string_literal: true

# This file sets up the local database. Pulling the JSON from the S3 bucket and populating the tables.

# I started here so that I could get started on the view quickly.

require 'net/http'
require 'json'

Article.destroy_all
User.destroy_all
Address.destroy_all
Value.destroy_all

# Thought I'd use Geofactory at this point to create a postgis location point.
GEOFACTORY = RGeo::ActiveRecord::SpatialFactoryStore.instance.factory(geo_type: 'st_point')

# Creates the Olio object
def olio_object
  url = 'https://s3-eu-west-1.amazonaws.com/olio-staging-images/developer/test-articles-v4.json'
  uri = URI(url)
  response = Net::HTTP.get(uri)
  JSON.parse(response)
end

count = 1

puts 'Creating articles...'

olio_object.each do |article|
  puts "Creating article #{count} user..."
  User.find_or_create_by(id: article['user']['id']) do |u|
    u.first_name     = article['user']['first_name']
    u.current_avatar = article['user']['current_avatar']['small']
    u.roles          = article['user']['roles']
    u.rating         = article['user']['rating']
    u.verifications  = article['user']['verifications']
    u.updated_at     = Time.now
  end
  
  puts "Creating article #{count}..."
  Article.create(
    {
      id: article['id'],
      title: article['title'],
      description: article['description'],
      section: article['section'],
      collection_notes: article['collection_notes'],
      status: article['status'],
      image: article['images'][0]['files']['large'],
      user_id: article['user']['id'],
      is_owner: article['is_owner'],
      created_at: Time.now
    }
  )

  puts 'adding article location...'
  article['location'] && Address.create(
    {
      town: article['location']['town'],
      country: article['location']['country'],
      location: GEOFACTORY.point(article['location']['longitude'], article['location']['latitude']),
      distance: article['location']['distance'],
      locatable_id: article['id'],
      locatable_type: 'Article',
      created_at: Time.now
    }
  )

  puts 'adding article value...'
  Value.create(
    {
      price: article['value']['price'],
      currency: article['value']['currency'],
      payment_type: article['value']['payment_type'],
      article_id: article['id'],
      created_at: Time.now
    }
  )

  puts 'adding article reactions...'
  Reaction.find_or_create_by(article_id: article['id']) do |r|
    r.likes       = article['reactions']['likes']
    r.by_user     = article['reactions']['by_user']
    r.views       = article['reactions']['views']
    r.impressions = article['reactions']['impressions']
    r.article_id  = article['id']
    r.updated_at  = Time.now
  end

  puts 'adding user location...'
  Address.find_or_create_by(locatable_id: article['user']['id']) do |l|
    l.location       = GEOFACTORY.point(article['user']['location']['longitude'], article['user']['location']['latitude'])
    l.locatable_id   = article['user']['id']
    l.locatable_type = 'User'
    l.updated_at     = Time.now
  end
  count += 1
end

puts 'The database has been prepared, please run "rails s" on your command line and navigate to "http://localhost:3000" in your favourite browser'