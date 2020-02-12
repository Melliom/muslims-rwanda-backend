# frozen_string_literal: true

FactoryBot.define do
  factory :sheikh do
    names { Faker::Name.name  }
    tel { "0789863456" }
    address { Faker::Address.street_address  }

    trait :with_avatar do
      avatar { fixture_file_upload(Rails.root.join("spec", "support", "assets", "abd.jpg"), "image/jpg") }
    end
  end
end
