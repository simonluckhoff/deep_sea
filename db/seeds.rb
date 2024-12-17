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
  { title: "Reef Rover", description: "A pair of high-grip water shoes", price: 55, image_url: "https://keyassets.timeincuk.net/inspirewp/live/wp-content/uploads/sites/21/2022/03/ecathlon-swimshoe.jpg" },
  { title: "HydraGlide", description: "A streamlined, high-speed underwater scooter", price: 350, image_url: "https://us.sublue.com/cdn/shop/files/N.jpg?v=1734076818&width=5472" },
  { title: "AquaSentinel", description: "A real-time water quality monitor for diving", price: 180, image_url: "https://www.royaleijkelkamp.com/media/4hnp0bjw/scuba-50-field.jpg" },
  { title: "BreezeShield", description: "A portable underwater windbreak", price: 110, image_url: "https://i.natgeofe.com/n/3313b8a3-4565-44fe-aefb-5af05906724e/underwater-habitat-bahamas-tent.jpg?w=2560&h=2048" },
  { title: "Triton Mask", description: "A full-face mask with integrated HUD display", price: 250, image_url: "https://diving.oceanreefgroup.com/wp-content/uploads/sites/3/2022/09/DSC02530__60738.jpg" },
  { title: "AquaTrek", description: "An amphibious backpack for diving expeditions", price: 135, image_url: "https://www.sporthouse.ie/cdn/shop/products/travel-bag-for-amphibious-voyager-light-evo-black-60lt_34604_zoom_700x933.jpg?v=1624306690" },
  { title: "Poseidon Pro", description: "A customizable underwater propulsion system", price: 500, image_url: "https://www.unmannedsystemstechnology.com/wp-content/uploads/2021/10/ROV-marine-thrusters-e1634124128427.webp" },
  { title: "Diver's Aura", description: "A wearable oxygen regulator with enhanced filtration", price: 220, image_url: "https://media.istockphoto.com/id/1270432316/photo/oxygen-concentrator-bar-gauge-measurement-liter.jpg?s=612x612&w=0&k=20&c=Fj9Wg8dk3PEAMHT_P2rNoQL6adHPZsttOmWQx5VWx8Q=" },
  { title: "WaveBreaker", description: "A portable, collapsible dive buoy with GPS tracking", price: 140, image_url: "https://divernet.com/wp-content/uploads/2024/04/USBL-Buoy-1024x564.jpg" },
  { title: "AquaWhisper", description: "A silent underwater communication device", price: 160, image_url: "https://alertdiver.eu/wp-content/uploads/2023/06/alertdiver-enhancing-underwater-communication-the-buddy-watcher-banner-2560x1120-1.jpg" },
  { title: "SubMeridian", description: "A compact sonar device for underwater navigation", price: 200, image_url: "https://www.ndiver-military.com/storage/uploads/products/707/nimrod-v2-LKjV.jpg" },
  { title: "AquaSphere", description: "A transparent, inflatable underwater habitat", price: 3200, image_url: "https://img.freepik.com/premium-photo/woman-blue-swimsuit-standing-wooden-dock-front-large-inflatable-transparent-structure-turquoise-ocean_14117-1051628.jpg" },
  { title: "DeepDive Gloves", description: "Thermal-protective gloves with enhanced grip for deep diving", price: 85, image_url: "https://www.dresseldivers.com/wp-content/uploads/Dive-Gloves-3-guantes-de-buceo.jpg" },
  { title: "HydroFlare", description: "An underwater signal flare for emergency situations", price: 70, image_url: "https://sng.ie/wp-content/uploads/2024/06/MOB_253RE-1024x687.webp" },
  { title: "EchoFinder", description: "Portable sonar device for locating underwater objects", price: 190, image_url: "https://www.j-tekmarine.com/wp-content/uploads/2024/01/Garmin-Fish-Finders.jpg" },
  { title: "SharkShield", description: "Electromagnetic shark repellent wearable band", price: 150, image_url: "https://www.sharkbanz.com.au/cdn/shop/files/Sharkbanz_Bethany_Hamilton_BH_Shark_Deterrent_Ocean_Safety_Beach_Hawaii-Soul-Surfer-Unstoppable-Prevent-Shark-Bite-Attack-Product-Effective.jpg?v=1715718648" },
  { title: "CurrentCrawler", description: "A small, remotely operated underwater vehicle for exploration", price: 850, image_url: "https://www.ecoptik.net/uploads/image/20230522/About_underwater_ROV..jpg" },
  { title: "CoralClaw", description: "A precision tool for carefully handling delicate coral", price: 45, image_url: "https://www.aquariumsource.com/wp-content/uploads/2024/03/Coral-Fragging.jpg" },
  { title: "TidalForce", description: "A high-tech, eco-friendly tidal energy generator for underwater camps", price: 1500, image_url: "https://cdn.inspenet.com/turbina-subacuatica-624x351.jpeg" },
  { title: "Neptune Boots", description: "Water-resistant boots with retractable fins for walking on the seabed", price: 250, image_url: "https://seavenger.com/cdn/shop/articles/SV-B600_Maui_-_Day_3-619_X_1500x.jpg?v=1631194124" },
  { title: "Vortex Mask", description: "A diving mask with built-in filtration and anti-fog system", price: 120, image_url: "https://shopstylereview.com/wp-content/uploads/2023/08/Snorkel-Mask-Foldable-Anti-Fog-Diving-Mask-Set-with-Full-Dry-Top-System-for-Free-Swim-Professional-Snorkeling-Gear-Adult-5.jpg" },
  { title: "AquaPulse", description: "A portable underwater heart rate monitor", price: 90, image_url: "https://www.yourswimlog.com/wp-content/uploads/2018/02/Best-Waterproof-Heart-Rate-Monitor-for-Swimmers.jpg" },
  { title: "HydraDock", description: "A mobile docking station for charging underwater drones", price: 450, image_url: "https://assets.newatlas.com/dims4/default/9543595/2147483647/strip/true/crop/8256x5504+0+0/resize/2880x1920!/quality/90/?url=http%3A%2F%2Fnewatlas-brightspot.s3.amazonaws.com%2F7b%2Fde%2Fd823e8f246008048aac9ca4e8dc5%2Fseasam-05-novembre-2019-d6500.jpg" },
  { title: "FlareWhip", description: "A flexible underwater rescue rope with built-in flare signaling system", price: 100, image_url: "https://img.rezdy.com/PRODUCT_IMAGE/7166/rolling_2_lg.jpg" },
  { title: "Submarine Tent", description: "A collapsible, inflatable tent designed for underwater camping", price: 2000, image_url: "https://oceanopportunity.com/wp-content/uploads/2021/07/33.-MCU-Tent-underwater-scaled.jpg" },
  { title: "HydroPaddle", description: "An electric paddleboard with regenerative energy capabilities", price: 800, image_url: "https://blog.boostsurfing.com/wp-content/uploads/2023/09/rover-motorized-paddle-board.jpg" },
  { title: "EchoMask", description: "An augmented reality diving mask with built-in sonar and live mapping", price: 400, image_url: "https://www.panoxdisplay.com/uploadfile/images/application/ar_diving.jpg" }
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
