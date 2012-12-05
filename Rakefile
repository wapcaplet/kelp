require 'rubygems'
require 'rspec/core/rake_task'
require 'cucumber/rake/task'

desc "Run RSpec tests with coverage analysis"
RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = 'spec/**/*_spec.rb'
  t.rspec_opts = ['--color', '--format doc']
end

desc "Run Cucumber tests with coverage analysis"
Cucumber::Rake::Task.new(:cucumber) do |t|
  t.cucumber_opts = [
    "--format pretty",
    "--tags ~@wip",
  ]
end

desc "Run RSpec and Cucumber tests with coverage analysis"
task :all do |t|
  rm 'coverage.data' if File.exist?('coverage.data')
  Rake::Task['spec'].invoke
  Rake::Task['cucumber'].invoke
end

task :default => ['all']

