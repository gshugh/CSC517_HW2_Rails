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
  admin: true,
  agent: false,
  customer: false
)
