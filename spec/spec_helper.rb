require 'rspec'
require 'capybara'
require 'capybara/dsl'
require 'kelp'
require File.expand_path(File.dirname(__FILE__) + '/test_app/test_app')

RSpec.configure do |config|
  config.include Capybara
  config.include Kelp::Attribute
  config.include Kelp::Dropdown
  config.include Kelp::Field
  config.include Kelp::Navigation
  config.include Kelp::Scoping
  config.include Kelp::Visibility
  config.after do
    Capybara.reset_sessions!
    Capybara.use_default_driver
  end
  config.before do
    Capybara.default_driver = :rack_test
    Capybara.default_selector = :css
    Capybara.app = TestApp
  end
end

