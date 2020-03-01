# frozen_string_literal: true

require "rails_helper"

RSpec.describe Sheikh, type: :model do
  before :each do
    @sheikh = FactoryBot.build(:sheikh, :with_avatar)
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
    @sheikh.telephone = "99349"
    @sheikh.save
    expect(@sheikh.errors[:telephone].first).to eq("is the wrong length (should be 10 characters)")
    expect(@sheikh).to_not be_valid
  end

  context "role should be of type enum" do
    it { should define_enum_for(:role) }

    it do
      should define_enum_for(:role).
        with_values([:regular, :imam])
    end
  end

  it "should be saved successfully" do
    expect(@sheikh).to be_valid
  end

  it { is_expected.to validate_content_type_of(:avatar).rejecting("text/plain", "text/xml") }
end
