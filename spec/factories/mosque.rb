# frozen_string_literal: true

FactoryBot.define do
  factory :mosque do
    name { Faker::Name.name  }
    cashpower { Faker::Number.leading_zero_number(digits: 7) }
    address { Faker::Address.street_address  }
    size { "medium"  }
    momo_number { "078" + Faker::PhoneNumber.subscriber_number(length: 7) }
    lng { Faker::Address.longitude }
    lat { Faker::Address.latitude }
  end
end
