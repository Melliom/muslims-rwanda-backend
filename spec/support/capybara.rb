# frozen_string_literal: true

# spec/support/capybara.rb


# Setup chrome headless driver
Capybara.server = :puma, { Silent: true }

Capybara.register_driver :chrome_headless do |app|
  options = ::Selenium::WebDriver::Chrome::Options.new

  options.add_argument("--no-sandbox")
  options.add_argument("--headless")
  options.add_argument("--disable-dev-shm-usage")

  Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
end

Capybara.javascript_driver = :chrome_headless

# Setup rspec
RSpec.configure do |config|
  config.before(:each, type: :features) do
    driven_by :rack_test
  end

  config.before(:each, type: :features, js: true) do
    driven_by :selenium_chrome_headless
  end
end
