# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# Apple Park Way
Location.find_or_create_by!(postal_code: "95014") do |location|
  location.city = "Cupertino"
  location.state = "California"
  location.lat = 37.3322056
  location.lng = -122.0110264
end

# Pier 39 Fisherman's Wharf
Location.find_or_create_by!(postal_code: "94133") do |location|
  location.city = "San Francisco"
  location.state = "California"
  location.lat = 37.8096616
  location.lng = -122.4102586
end
