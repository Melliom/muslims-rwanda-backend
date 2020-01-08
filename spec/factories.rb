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
end
