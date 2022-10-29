json.extract! user, :id, :first_name, :roles, :location, :rating, :verification, :current_avatar, :created_at, :updated_at
json.url user_url(user, format: :json)
