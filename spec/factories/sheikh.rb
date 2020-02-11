# frozen_string_literal: true

FactoryBot.define do
  factory :sheikh do
    names { Faker::Name.name  }
    tel { "0789863456" }
    address { Faker::Address.street_address  }
    avatar { Faker::Internet.url  }
  end
end
