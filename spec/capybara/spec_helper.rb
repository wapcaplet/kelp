require 'rspec'
require 'capybara'
require 'capybara/dsl'
require File.expand_path(File.dirname(__FILE__) + '/../test_app/test_app')
require File.expand_path(File.dirname(__FILE__) + '/../../lib/capybara/web_helper')

RSpec.configure do |config|
  config.include Capybara
  config.include WebHelper
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

