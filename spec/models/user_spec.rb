# frozen_string_literal: true

require "rails_helper"

RSpec.describe User, type: :model do
  before :each do
    @user = FactoryBot.build(:user)
  end

  # a better way of initializing user
  # subject(:user) { build(:user) }

  it "email should not be empty" do
    @user.email = nil
    expect(@user).to_not be_valid
  end

  it "email should be a valid email" do
    @user.email = "hadadgmail.com"
    expect(@user).to_not be_valid
  end

  # using shoulda-matcher
  it { should validate_presence_of(:email) }

  it "password should not be under 6 characters" do
    @user.password = "ju"
    expect(@user).to_not be_valid
  end
end
