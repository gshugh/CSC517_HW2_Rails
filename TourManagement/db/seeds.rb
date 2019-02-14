# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Seed the database with one admin role
# Every team member will need to run db:seed command to get this admin in their DB
# Modified to support user login
# All team members now must remove any existing users and re-seed, or they may get problems like:
# https://stackoverflow.com/questions/11037864/bcrypterrorsinvalidhash-when-trying-to-sign-in
User.create(
  email: "admin@admin.com",
  name: "Admin",
  password_digest: User.digest('password_1234'),
  admin: true, agent: false, customer: false
)
case Rails.env
when "development"
# Load users
  User.create(
      email: "jason@hugh.com",
      name: "Jason",
      password_digest: User.digest('jason'),
      admin: false, agent: true, customer: false
  )
  User.create(
      email: "george@hugh.com",
      name: "George",
      password_digest: User.digest('george'),
      admin: false, agent: false, customer: true
  )
  User.create(
      email: "ann@leininger.com",
      name: "Ann",
      password_digest: User.digest('ann'),
      admin: false, agent: true, customer: true
  )
# Load locations
  Location.create(state: "NC", country: "USA")
  Location.create(state: "SC", country: "USA")
  Location.create(state: "GA", country: "USA")
# Load tours
  Tour.create(
      name: "First Tour",
      description: "First tour.",
      price_in_cents: 19999,
      deadline:   DateTime.new(2019,3,2),
      start_date: DateTime.new(2019,3,3),
      end_date:   DateTime.new(2019,3,10),
      operator_contact: "First Tour Co",
      num_seats: 100
  )
  Tour.create(
      name: "Second Tour",
      description: "Second tour.",
      price_in_cents: 20100,
      deadline:   DateTime.new(2020,3,2),
      start_date: DateTime.new(2020,3,3),
      end_date:   DateTime.new(2020,3,10),
      operator_contact: "First Tour Co",
      num_seats: 10
  )
end