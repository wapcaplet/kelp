# env.rb

require File.join(File.dirname(__FILE__), '..', '..', 'app.rb')
require 'capybara'
require 'capybara/cucumber'
require 'rspec/core'
require File.expand_path(File.dirname(__FILE__) + '../../../../../lib/kelp')

TestApp.set(:environment, :test)

Capybara.app = TestApp

class TestAppWorld
  include Capybara::DSL
end

World do
  TestAppWorld.new
end

