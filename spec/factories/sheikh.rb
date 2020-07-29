# frozen_string_literal: true

FactoryBot.define do
  factory :sheikh do
    names { Faker::Name.name  }
    telephone { "078" + Faker::PhoneNumber.subscriber_number(length: 7) }
    address { Faker::Address.street_address  }

    trait :with_avatar do
      avatar { fixture_file_upload(Rails.root.join("spec", "support", "assets", "abd.jpg"), "image/jpg") }
    end
  end
  factory :abdul, class: "Sheikh" do
    names { "abdul rahman"  }
    telephone { "0782080334" }
    address { Faker::Address.street_address  }

    trait :with_avatar do
      avatar { fixture_file_upload(Rails.root.join("spec", "support", "assets", "abd.jpg"), "image/jpg") }
    end
  end
end
