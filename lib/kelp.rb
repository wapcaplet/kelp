require 'kelp/attribute'
require 'kelp/checkbox'
require 'kelp/dropdown'
require 'kelp/field'
require 'kelp/navigation'
require 'kelp/scoping'
require 'kelp/visibility'

module Kelp
  class << self
    attr_writer :driver

    # @return [Symbol]
    #   Name of the default driver used by Kelp
    def default_driver
      :capybara
    end

    # @return [Symbol]
    #   Name of the current driver used by Kelp (:capybara or :webrat)
    def driver
      @driver || default_driver
    end
  end
end

