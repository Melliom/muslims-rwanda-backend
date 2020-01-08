# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


User.find_or_create_by(email: ENV["ADMIN_EMAIL"]) do |admin|
  admin.email = ENV["ADMIN_EMAIL"]
  admin.password = ENV["ADMIN_PASSWORD"]
  admin.avatar = "https://res.cloudinary.com/dutstern8/image/upload/v1578513174/user_rpyd6v.png"
  admin.confirmed_at = Time.zone.now
  admin.roles = "super_admin"
end
