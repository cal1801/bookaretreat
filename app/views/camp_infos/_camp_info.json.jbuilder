json.extract! camp_info, :id, :type_id, :description, :url, :camp_id, :created_at, :updated_at
json.url camp_info_url(camp_info, format: :json)