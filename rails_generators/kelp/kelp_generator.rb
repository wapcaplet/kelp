# This generator adds web_steps.rb to the step_definitions directory,
# replacing any web_steps.rb added by cucumber-rails.

generator_base = defined?(Rails) ? Rails::Generator::Base : RubiGen::Base

class KelpGenerator < generator_base
  def manifest
    record do |m|
      m.directory 'features/step_definitions'
      m.file 'web_steps.rb', 'features/step_definitions/web_steps.rb'
    end
  end

protected

  def banner
    "Usage: #{$0} kelp"
  end

end
