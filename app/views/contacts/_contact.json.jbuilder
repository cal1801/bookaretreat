json.extract! contact, :id, :f_name, :l_name, :title, :address_id, :created_at, :updated_at
json.url contact_url(contact, format: :json)