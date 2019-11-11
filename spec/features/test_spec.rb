# frozen_string_literal: true

require "rails_helper"

describe "the signin process" do
  it "get me to try" do
    visit "/try"
    click_button "Change greetings!"
    expect(page).to have_content("Greetings:Holla!")
  end
end
