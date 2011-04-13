# app_steps.rb

require 'fileutils'

Given /^a (\w+) application with the latest Kelp step definitions$/ do |platform|
  app_dir = File.join(root_dir, 'examples', "#{platform}_app")
  installed_steps = File.join(app_dir, 'features', 'step_definitions', 'kelp_steps.rb')
  latest_steps = File.join(root_dir, 'lib', 'generators', 'kelp', 'step_definitions', 'kelp_steps.rb')
  # Remove the installed kelp_steps.rb, if any, then install the latest one
  FileUtils.rm(installed_steps) if File.exists?(installed_steps)
  FileUtils.cp_r(latest_steps, installed_steps)
end

When /^I run "(.+)" in the (\w+) app$/ do |command, platform|
  command.gsub!('cucumber', "#{Cucumber::RUBY_BINARY} #{Cucumber::BINARY}")
  app_dir = File.join(root_dir, 'examples', "#{platform}_app")
  Dir.chdir(app_dir) do
    @output = `#{command}`
  end
end

Then /^the results should be:$/ do |expected_results|
  @output.should include(expected_results)
end

