# frozen_string_literal: true

require 'net/http'
require 'json'

Article.destroy_all
User.destroy_all
Address.destroy_all
Reaction.destroy_all
Value.destroy_all

GEOFACTORY = RGeo::ActiveRecord::SpatialFactoryStore.instance.factory(geo_type: 'st_point')

def olio_object
  url = 'https://s3-eu-west-1.amazonaws.com/olio-staging-images/developer/test-articles-v4.json'
  uri = URI(url)
  response = Net::HTTP.get(uri)
  JSON.parse(response)
end

count = 1

puts 'Creating articles...'

olio_object.each do |article|
  puts count
  puts "Creating article #{count}..."
  Article.create(
    {
      id: article['id'],
      title: article['title'],
      description: article['description'],
      section: article['section'],
      collection_notes: article['collection_notes'],
      status: article['status'],
      images: article['images'],
      user_id: article['user']['id'],
      is_owner: article['is_owner']
    }
  )

  puts 'adding article location...'
  article['location'] && Address.create(
    {
      town: article['location']['town'],
      country: article['location']['country'],
      location: GEOFACTORY.point(article['location']['longitude'], article['location']['latitude']),
      locatable_id: article['id'],
      locatable_type: 'Article'
    }
  )

  puts 'adding article reaction...'
  Reaction.create(
    {
      likes: article['reactions']['likes'],
      by_user: article['reactions']['by_user'],
      views: article['reactions']['views'],
      impressions: article['reactions']['impressions']
    }
  )

  puts 'adding article value...'
  Value.create(
    {
      price: article['value']['price'],
      currency: article['value']['currency'],
      payment_type: article['value']['payment_type']
    }
  )

  puts "Creating article #{count} user..."
  User.find_or_create_by(id: article['user']['id']) do |u|
    u.first_name     = article['user']['first_name']
    u.current_avatar = [article['user']['current_avatar']]
    u.roles          = article['user']['roles']
    u.rating         = article['user']['rating']
    u.verifications  = article['user']['verifications']
  end

  puts 'adding user location...'
  Address.find_or_create_by(locatable_id: article['user']['id']) do |l|
    l.location = GEOFACTORY.point(article['user']['location']['longitude'], article['user']['location']['latitude'])
    l.locatable_id = article['user']['id']
    l.locatable_type = 'User'
  end
  count += 1
end

puts 'The database has been prepared, please run "rails server" on your command line and navigate to "http://localhost:3000" in your favourite browser'
