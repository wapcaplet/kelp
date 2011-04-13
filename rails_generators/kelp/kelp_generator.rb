# This generator adds Kelp steps to the step_definitions directory

generator_base = defined?(Rails) ? Rails::Generator::Base : RubiGen::Base

class KelpGenerator < generator_base
  def manifest
    record do |m|
      m.directory 'features/step_definitions'
      m.file 'kelp_steps.rb', 'features/step_definitions/kelp_steps.rb'
    end
  end

protected

  def banner
    "Usage: #{$0} kelp"
  end

end
