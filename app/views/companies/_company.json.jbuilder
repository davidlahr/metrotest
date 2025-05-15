json.extract! company, :id, :name, :street_address, :extra_address, :city, :state, :zip, :phone, :contact, :created_at, :updated_at
json.url company_url(company, format: :json)
