# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
puts "Cleaning database..."
Gear.destroy_all
User.destroy_all

puts "Creating users..."
user = User.create!(email: 'test@example.com', password: 'password')

puts "Creating gears..."

# Defining gear attributes
TERRA_QUEST = { title: "TerraQuest", description: "A sturdy, waterproof backpack", price: 85, user: user }
STORM_CHASER = { title: "StormChaser", description: "A lightweight, breathable jacket", price: 60, user: user }
TRAIL_BLAZER = { title: "TrailBlazer", description: "A rugged, feature-rich GPS watch", price: 140, user: user }
OCEAN_VOYAGER = { title: "Ocean Voyager", description: "A high-performance diving suit", price: 200, user: user }
SUN_EXPLORER = { title: "Sun Explorer", description: "UV-protective sunglasses", price: 45, user: user }
WAVE_RIDER = { title: "Wave Rider", description: "A versatile paddleboard", price: 500, user: user }
TIDE_MASTER = { title: "Tide Master", description: "A digital tide and weather monitor", price: 120, user: user }
SEA_HUNTER = { title: "Sea Hunter", description: "A waterproof, shock-resistant flashlight", price: 70, user: user }
CORAL_GUARDIAN = { title: "Coral Guardian", description: "Eco-friendly reef-safe sunscreen", price: 25, user: user }
REEF_ROVER = { title: "Reef Rover", description: "A pair of high-grip water shoes", price: 55, user: user }

# Creating gears
[
  TERRA_QUEST, STORM_CHASER, TRAIL_BLAZER, OCEAN_VOYAGER,
  SUN_EXPLORER, WAVE_RIDER, TIDE_MASTER, SEA_HUNTER,
  CORAL_GUARDIAN, REEF_ROVER
].each do |attributes|
  gear = Gear.create!(attributes)
  puts "Created #{gear[:title]}"
end

puts "Finished!"
