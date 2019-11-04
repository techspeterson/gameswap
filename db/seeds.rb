# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'open-uri'

admin = User.new(username: "admin", email: "fake@email.com", password: "secret", password_confirmation: "secret")
admin.user_detail = UserDetail.new(bio: "admin user", is_admin: true)
admin.save!

user = User.new(username: "cherry", email: "bigacid@superdeadly.com", password: "nemesis", password_confirmation: "nemesis")
user.user_detail = UserDetail.new(bio: "big acid super deadly")
user.save!

5.times do |i|
  password = Faker::Internet.password(min_length: 8)
  user = User.new(username: Faker::Internet.unique.username(specifier: 5..15, separators: %w(_ -)), email: Faker::Internet.unique.email, password: password, password_confirmation: password)
  user.user_detail = UserDetail.new(bio: Faker::Lorem.paragraph)
  user.user_detail.avatar.attach(io: File.new(open(Faker::Avatar.image)), filename: "avatar.png")
  user.save!
end

ISO3166::Country.all_translated.each do |country|
  Country.create(name: country)
end

action_games = ["Platformer", "Shooter", "Fighting", "Beat 'em up", "Stealth", "Survival", "Battle Royale", "Rhythm"]
action_adventure_games = ["Survival horror", "Metroidvania"]
adventure_games = ["Text-based", "Point-and-click", "Visual novel"]
rpgs = ["Action", "Roguelike", "Tactical", "Sandbox"]
simulation_games = ["Construction", "Life", "Vehicle"]
strategy_games = ["Real-time", "Turn-based", "MOBA", "Tower defense"]
sports_games = ["Racing"]
other_games = ["Puzzle", "Party", "Other"]

Genre.create(name: "Action")
action_games.each do |genre|
  Genre.create!(name: "Action (#{genre})")
end

Genre.create(name: "Adventure")
adventure_games.each do |genre|
  Genre.create!(name: "Adventure (#{genre})")
end

Genre.create(name: "Action-adventure")
action_adventure_games.each do |genre|
  Genre.create!(name: "Action-adventure (#{genre})")
end

Genre.create(name: "RPG")
rpgs.each do |genre|
  Genre.create!(name: "RPG (#{genre})")
end

Genre.create(name: "Simulation")
simulation_games.each do |genre|
  Genre.create!(name: "Simulation (#{genre})")
end

Genre.create(name: "Strategy")
strategy_games.each do |genre|
  Genre.create!(name: "Strategy (#{genre})")
end

Genre.create(name: "Sports")
sports_games.each do |genre|
  Genre.create!(name: "Sports (#{genre})")
end

other_games.each do |genre|
  Genre.create!(name: genre)
end

gen_1 = [["All 1st generation", ""]]
gen_2 = [["Atari 2600", "Atari"], ["Atari 5200", "Atari"]]
gen_3 = [["NES", "Nintendo"]]
gen_4 = [["SNES", "Nintendo"], ["Game Boy", "Nintendo"]]
gen_5 = [["PlayStation", "Sony"], ["N64", "Nintendo"], ["Game Boy Color", "Nintendo"]]
gen_6 = [["PlayStation 2", "Sony"], ["GameCube", "Nintendo"], ["Xbox", "Microsoft"], ["Game Boy Advance", "Nintendo"]]
gen_7 = [["Xbox 360", "Microsoft"], ["PlayStation 3", "Sony"], ["Wii", "Nintendo"], ["DS", "Nintendo"], ["PlayStation Portable", "Sony"]]
gen_8 = [["Wii U", "Nintendo"], ["PlayStation 4", "Sony"], ["Xbox One", "Microsoft"], ["Switch", "Nintendo"], ["3DS", "Nintendo"], ["PlayStation Vita", "Sony"]]

all_gens = [gen_1, gen_2, gen_3, gen_4, gen_5, gen_6, gen_7, gen_8]

all_gens.each do |gen|
  gen.each_with_index do |game, index|
    Platform.create!(name: game[0], manufacturer: game[1], generation: (index + 1))
  end
end

users = User.all
10.times do |i|
  Listing.create!(title: Faker::Game.title, condition: rand(0..3), price: rand(1..50), user: users.sample, platform: Platform.all.sample, genre: Genre.all.sample)
end