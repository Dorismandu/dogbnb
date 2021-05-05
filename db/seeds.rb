require 'faker'
require "open-uri"

puts "cleaning bookings DB"
Booking.destroy_all
puts "booking DB cleaned!"

puts "cleaning Dogs DB"
Dog.destroy_all
puts "Dogs DB cleaned!"

descriptions = [
  "Amazing dog, loves to walk for hours and greet every other dogs he encounters. Very friendly with strangers. I am looking for someone who could walk him in the afternoon.",
  "My dog loves to go on peaceful, slow walks. He doesn't play a lot, but enjoy smelling everything around him. He is a bit afraid of other dogs but has no problem with being walked by strangers.",
  "I am looking for someone who could run with my dog a couple of times a week. He really needs to exercise, and sadly I don't have the time at the moment. Cycling is also possible, as I taught him how to run next to a bicycle.",
  "Looking for someone who could spend time with my dog a few times a week, as I work late and don't want to leave him alone the full day. I could bring him to your place, or you can come dog-sitting in my flat for a few hours. He is very calm, but enjoy playing now and then."
]
i = 0
12.times do
  i += 1
  my_dog = Dog.new(
    name:  Faker::Creature::Dog.name,
    breed: Faker::Creature::Dog.breed,
    age: rand(1..15),
    address: Faker::Address.full_address,
    description: descriptions.sample,
  )
  my_dog.user = User.last
  j = 0
  3.times do
    j += 1
    file = URI.open('https://source.unsplash.com/collection/9718726')
    my_dog.photos.attach(io: file, filename: "dog_#{i}_#{j}", content_type: 'image/png')
  end
  my_dog.save
  puts "Dog added"
end
puts "Dogs DB seeded!"


d = 1
5.times do
  my_booking = Booking.new(
    pickup_time: DateTime.current.beginning_of_day + d,
    giveback_time: DateTime.current.middle_of_day + d,
    pickup_location: Faker::Address.full_address,
    giveback_location: Faker::Address.full_address,
    activity: "walk",
    status: rand(0..2)
  )

  my_booking.user = User.first
  my_booking.dog = Dog.first

  my_booking.save
  puts "Booking added"
  d+=1
end
puts "Bookings DB seeded!"
