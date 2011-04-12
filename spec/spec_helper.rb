require 'rspec'

# Supported drivers
require 'capybara'
require 'capybara/dsl'
#require 'webrat'

require 'kelp'
require File.expand_path(File.join(File.dirname(__FILE__), '..', 'examples', 'sinatra_app', 'app'))

RSpec.configure do |config|
  config.include Capybara
  #config.include Webrat::Methods

  config.include Kelp::Attribute
  config.include Kelp::Checkbox
  config.include Kelp::Dropdown
  config.include Kelp::Field
  config.include Kelp::Navigation
  config.include Kelp::Scoping
  config.include Kelp::Visibility

  config.before do
    #Kelp.driver = :webrat
    Capybara.default_driver = :rack_test
    Capybara.default_selector = :css
    Capybara.app = TestApp
  end

  config.after do
    Capybara.reset_sessions!
    Capybara.use_default_driver
  end
end

#Webrat.configure do |config|
  #config.mode = :rack
#end

