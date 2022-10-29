# frozen_string_literal: true

require 'net/http'
require 'json'

def olio_object
  url = 'https://s3-eu-west-1.amazonaws.com/olio-staging-images/developer/test-articles-v4.json'
  uri = URI(url)
  response = Net::HTTP.get(uri)
  JSON.parse(response)
end

Article.destroy_all
User.destroy_all

puts olio_object

olio_object.each do |article|
  puts article, "ARTICLE"
  puts article.count, "ARTICLE COUNT"
  puts article["user"], "USER OBJECT"
  # Article.create()
end
