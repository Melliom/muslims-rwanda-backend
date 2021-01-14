# frozen_string_literal: true

require "rails_helper"

RSpec.describe Announcement, type: :model do
  before :each do
    @announcement = FactoryBot.build(:announcement)
  end

  it "title should be present" do
    @announcement.title = nil
    expect(@announcement).to_not be_valid
  end

  it "title should have a minimum of 3 characters" do
    @announcement.title = "aa"
    expect(@announcement).to_not be_valid
  end

  it "title should have a maximum of 300 characters" do
    @announcement.title = Faker::Lorem.paragraph_by_chars(number: 301)
    expect(@announcement).to_not be_valid
  end

  it "description should have a minimum of 3 characters" do
    @announcement.description = "aa"
    expect(@announcement).to_not be_valid
  end

  context "status should be of type enum and one of [active, archived]" do
    it { should define_enum_for(:status) }

    it do
      should define_enum_for(:status).
        with_values([:active, :archived])
    end
  end
end
