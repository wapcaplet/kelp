# This generator adds Kelp steps to the step_definitions directory

require 'rails/generators'

module Kelp
  class StepsGenerator < Rails::Generators::Base
    def manifest
      record do |m|
      end
    end

    #def generate
      #copy_file 'kelp_steps.rb', 'features/step_definitions/kelp_steps.rb'
    #end

    #def self.source_root
      #File.join(File.dirname(__FILE__), 'step_definitions')
    #end
  end
end

