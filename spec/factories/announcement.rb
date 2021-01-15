# frozen_string_literal: true

FactoryBot.define do
  factory :announcement do
    title { Faker::Lorem.sentence  }
    description { Faker::Lorem.paragraph_by_chars(number: 256) }
    tags { ["swallah", "urgent"] }
  end
end
