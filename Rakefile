require 'rubygems'
require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new do |spec|
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rspec_opts = ['--color', '--format doc']
end

desc "Generate RCov coverage report"
RSpec::Core::RakeTask.new(:rcov) do |spec|
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rspec_opts = ['--color', '--format doc']
  spec.rcov = true
  spec.rcov_opts = %w{--exclude osx\/objc,gems\/,spec\/,features\/}
end

