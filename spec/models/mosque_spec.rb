# frozen_string_literal: true

require "rails_helper"

RSpec.describe Mosque, type: :model do
  before :each do
    @mosque = FactoryBot.build(:mosque)
  end

  it "name should be present" do
    @mosque.name = nil
    expect(@mosque).to_not be_valid
  end

  it "address should not be out of range 3..100" do
    @mosque.address = "ds"
    @mosque.save
    expect(@mosque.errors[:address].first).to eq("is too short (minimum is 3 characters)")
    expect(@mosque).to_not be_valid
  end

  context "role should be of type enum and one of [small, medium, large]" do
    it { should define_enum_for(:size) }

    it do
      should define_enum_for(:size).
        with_values([:small, :medium, :large])
    end
  end

  it "should be saved successfully" do
    expect(@mosque).to be_valid
  end
end
