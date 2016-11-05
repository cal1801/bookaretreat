json.extract! address, :id, :address, :address2, :city, :state, :zip, :lat, :lon, :created_at, :updated_at
json.url address_url(address, format: :json)