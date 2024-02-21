# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

Event.destroy_all
User.destroy_all
Attendance.destroy_all

require 'faker'
Faker::Config.locale = 'fr'
Faker::UniqueGenerator.clear

# utilisateurs
10.times do 
  user = User.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    description: Faker::Lorem.sentence,
    email: Faker::Internet.unique.email,
    password: Faker::Internet.password(min_length: 6, max_length: 15)
  )
end
puts "user crée"

# événements

5.times do
  
  admin_user = User.all.sample
  event = Event.create(
    admin_id: admin_user.id,
    title: Faker::Lorem.sentence(word_count: 3), 
    start_date: Faker::Time.forward(days: 30), 
    duration: rand(1..60) * 5, 
    description: Faker::Lorem.paragraph, 
    price: rand(1..1000), 
    location: ["Cannes", "Nice", "Saint-Laurent-du-Var", "Antibes"].sample
  )
end
puts "5 event crée"

#  participations aléatoires
all_events = Event.all
5.times do 
  user = User.all.sample
  event = Event.all.sample
  attendance = Attendance.create(stripe_customer_id: "123456", user: user, event: event)
end


#  URL d'image aléatoire
def generate_random_image_url(category)
  Faker::LoremFlickr.image(size: "300x200", search_terms: [category])
end


# événements avec des images aléatoires de la catégorie "concert"
10.times do
  Event.create(
    title: Faker::Lorem.sentence,
    description: Faker::LoremFlickr.image(size: "300x200", search_terms: ['concert']) # Utilisation de Faker::LoremFlickr pour générer l'URL de l'image
    # Ajoutez d'autres attributs selon vos besoins
  )
end




puts "Seed completed successfully!"

