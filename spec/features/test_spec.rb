# frozen_string_literal: true

require "rails_helper"

describe "test button" do
  it "say holla" do
    visit "/try"
    click_button "Change greetings!"
    expect(page).to have_content("Greetings:Holla!")
  end
end
