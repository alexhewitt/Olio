json.extract! article, :id, :title, :description, :section, :location, :value, :status, :reactions, :is_owner, :collection_notes, :images, :created_at, :updated_at
json.url article_url(article, format: :json)
