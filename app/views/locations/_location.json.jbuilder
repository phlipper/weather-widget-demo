json.extract! location, :id, :city, :state, :postal_code, :lat, :lng, :created_at, :updated_at
json.url location_url(location, format: :json)
