# frozen_string_literal: true

FactoryBot.define do
  factory :test do
    title { "yoo" }
    content { "just test" }
  end
  factory :user do
    email { "hadad@gmail.com" }
    password { "J*uD$J2l^v6Q" }
    confirmed_at { Time.zone.now }
  end
  factory :super_admin, class: "User" do
    email { "super_admin@gmail.com" }
    password { "J*uD$J2l^v6Q" }
    confirmed_at { Time.zone.now }
    roles { "super_admin" }
  end
end
