require 'rails/generators'

class KelpGenerator < Rails::Generators::Base
  def generate
    copy_file 'web_steps.rb', 'features/step_definitions/web_steps.rb'
  end

  def self.source_root
    File.expand_path('../templates', __FILE__)
  end
end

