# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
#   

# Company.create!(
#   name: "Kruger Industrial Smoothing",
#   street_address: "405 Morningview Ave",
#   city: "Pickerington",
#   state: "OH",
#   zip: "43147",
#   contact: "Jeff Wheeler"
# )


User.create!(
    email: "james@example.com",
    first_name: "James",
    last_name: "Kunkle",
    password: "secret",
    role: "Site-Admin",
    company_id: 1
    )

# user = User.find_by(email: "david@example.com")
# user.role = "Site-Admin"


