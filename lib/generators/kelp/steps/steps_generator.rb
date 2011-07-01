require 'rails/generators'

module Kelp
  class StepsGenerator < Rails::Generators::Base
    def generate
      copy_file 'web_steps.rb', 'features/step_definitions/web_steps.rb'
    end

    def self.source_root
      File.join(File.dirname(__FILE__), 'templates')
    end
  end
end

