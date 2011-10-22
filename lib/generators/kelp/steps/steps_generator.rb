require 'rails/generators'

module Kelp
  class StepsGenerator < Rails::Generators::Base
    source_root File.expand_path('../templates', __FILE__)

    def generate
      copy_file 'web_steps.rb', 'features/step_definitions/web_steps.rb'
    end
  end
end
