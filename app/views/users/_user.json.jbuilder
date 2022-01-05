json.extract! user, :id, :firstName, :lastName, :email, :password, :schoolID, :isAdmin, :created_at, :updated_at
json.url user_url(user, format: :json)
