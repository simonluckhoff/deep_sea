puts "Cleaning database..."
Gear.destroy_all
User.destroy_all

puts "Creating users..."

# Creating a default user
user = User.find_or_create_by!(email: 'test@example.com') do |u|
  u.password = 'password'
end

puts "Created user: #{user.email}"

puts "Creating gears..."

require "open-uri"

# Defining gear data as an array of hashes with associated image URLs
gears_data = [
  { title: "TerraQuest", description: "A sturdy, waterproof backpack", price: 85, image_url: "https://keyassets.timeincuk.net/inspirewp/live/wp-content/uploads/sites/21/2021/08/future1621-1275-630x394.jpg" },
  { title: "StormChaser", description: "A lightweight, breathable jacket", price: 60, image_url: "https://m.media-amazon.com/images/I/81Q8Jmz--ZS._AC_UF1000,1000_QL80_.jpg" },
  { title: "TrailBlazer", description: "A rugged, feature-rich GPS watch", price: 140, image_url: "https://www.mbreviews.com/wp-content/uploads/2019/06/casio-wsd-f30-4.jpg" },
  { title: "Ocean Voyager", description: "A high-performance diving suit", price: 200, image_url: "https://www.beuchat-diving.com/img/cms/Atoll/Mono-Atoll-4F6A1412.jpg" },
  { title: "Sun Explorer", description: "UV-protective sunglasses", price: 45, image_url: "https://www.theinertia.com/wp-content/uploads/2020/08/Dragon-sunglasses-floating.jpg?x33258" },
  { title: "Wave Rider", description: "A versatile paddleboard", price: 500, image_url: "https://adventuresportsusa.com/cdn/shop/files/Screenshot2023-05-02171510_9cb21872-d126-4ee4-b8fe-cd1ecddb400e_grande.png?v=1683131786" },
  { title: "Tide Master", description: "A digital tide and weather monitor", price: 120, image_url: "https://cdn.globalso.com/frankstartech/Integrated-Wave-Buoy2.jpg" },
  { title: "Sea Hunter", description: "A waterproof, shock-resistant flashlight", price: 70, image_url: "https://klarustore.com/cdn/shop/articles/wsdsadsd_-1.jpg?v=1730968539" },
  { title: "Coral Guardian", description: "Eco-friendly reef-safe sunscreen", price: 25, image_url: "https://cdn.tatlerasia.com/asiatatler/i/hk/2020/05/18154805-beauty-eco-friendly-reef-ocean-safe-sunscreen_cover_1080x1350.jpg" },
  { title: "Reef Rover", description: "A pair of high-grip water shoes", price: 55, image_url: "https://keyassets.timeincuk.net/inspirewp/live/wp-content/uploads/sites/21/2022/03/ecathlon-swimshoe.jpg" }
]

# Creating gears and attaching unique images
gears_data.each do |gear_data|
  gear = Gear.find_or_create_by!(title: gear_data[:title]) do |g|
    g.description = gear_data[:description]
    g.price = gear_data[:price]
    g.user = user
  end

  puts "Created gear: #{gear.title}"

  # Attaching a unique image to each gear
  begin
    file = URI.open(gear_data[:image_url])
    gear.photo.attach(io: file, filename: "#{gear.title.downcase.gsub(' ', '_')}.jpg", content_type: "image/jpeg")
    gear.save!
    puts "Attached image to gear: #{gear.title}"
  rescue => e
    puts "Failed to attach image for #{gear.title}: #{e.message}"
  end
end

puts "Finished!"
