# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password',name: 'admin',role: 'Manager') if Rails.env.development?
Track.create!(name: 'os',intake: '38',typeoftrack: '9 month') if Rails.env.development?
Group.create!(name: 'A') if Rails.env.development?