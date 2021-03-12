require 'capybara/rspec'
require 'selenium/webdriver'

Capybara.app_host = 'https://coinmarketcap.com'

RSpec.configure do |config|
  include Capybara::DSL
end

Capybara.register_driver :not_headless_chrome do |app|
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument('--disable-gpu')

  Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
end

Capybara.register_driver :headless_chrome do |app|
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument('--headless')
  options.add_argument('--disable-gpu')

  Capybara::Selenium::Driver.new(app, browser: :chrome, options: options)
end

Capybara.register_driver :not_headless_firefox do |app|
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument('--disable-gpu')

  Capybara::Selenium::Driver.new(app, browser: :firefox, options: options)
end

Capybara.register_driver :headless_firefox do |app|
  options = Selenium::WebDriver::Chrome::Options.new
  options.add_argument('--headless')
  options.add_argument('--disable-gpu')

  Capybara::Selenium::Driver.new(app, browser: :firefox, options: options)
end

Capybara.default_max_wait_time = 10
Capybara.javascript_driver = :not_headless_chrome
