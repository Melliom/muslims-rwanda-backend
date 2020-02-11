# frozen_string_literal: true

require "rails_helper"

RSpec.describe Sheikh, type: :model do
  before :each do
    @sheikh = FactoryBot.build(:sheikh)
  end

  # a better way of initializing user
  # subject(:user) { build(:user) }

  it "names should not be present" do
    @sheikh.names = nil
    expect(@sheikh).to_not be_valid
  end

  it "names should not be out of range 3..100" do
    @sheikh.names = "du"
    @sheikh.save
    expect(@sheikh.errors[:names].first).to eq("is too short (minimum is 3 characters)")
    expect(@sheikh).to_not be_valid
  end

  it "tel should be 10 character" do
    @sheikh.tel = "99349"
    @sheikh.save
    expect(@sheikh.errors[:tel].first).to eq("is the wrong length (should be 10 characters)")
    expect(@sheikh).to_not be_valid
  end

  context "role should be of type enum" do
    it { should define_enum_for(:role) }

    it do
      should define_enum_for(:role).
        with_values([:regular, :imam])
    end
  end

  it "avatar should be a valid url" do
    @sheikh.avatar = "99349"
    @sheikh.save
    expect(@sheikh.errors[:avatar].first).to eq("is an invalid URL")
    expect(@sheikh).to_not be_valid
  end

  it "should be saved successfully" do
    expect(@sheikh).to be_valid
  end
end
