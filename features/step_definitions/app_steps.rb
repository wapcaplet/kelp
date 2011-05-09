# app_steps.rb

require 'fileutils'

Given /^the latest Kelp step definitions$/ do
  app_dir = File.join(root_dir, 'examples', "sinatra_app")
  installed_steps = File.join(app_dir, 'features', 'step_definitions', 'web_steps.rb')
  latest_steps = File.join(root_dir, 'rails_generators', 'kelp', 'templates', 'web_steps.rb')
  # Remove the installed web_steps.rb, if any, then install the latest one
  FileUtils.mkdir_p(File.dirname(installed_steps))
  FileUtils.rm(installed_steps) if File.exists?(installed_steps)
  FileUtils.cp_r(latest_steps, installed_steps)
end


When /^I run cucumber on "(.+)"$/ do |feature|
  cucumber = "#{Cucumber::RUBY_BINARY} #{Cucumber::BINARY}"
  opts = "-q --no-color"
  command = "#{cucumber} #{opts} features/#{feature}"
  app_dir = File.join(root_dir, 'examples', "sinatra_app")
  Dir.chdir(app_dir) do
    @output = `#{command}`
  end
end


# Ensure that the results include the expected lines, in the same order.
# Extra lines in the results are ignored.
Then /^the results should include:$/ do |expected_lines|
  # Full actual output, for error reporting
  got = @output.collect {|line| "  #{line}"}.join
  # Remove leading whitespace and split into lines
  got_lines = @output.gsub(/^\s*/, '').split("\n")
  want_lines = expected_lines.gsub(/^\s*/, '').split("\n")
  last_index = -1
  # Ensure that each wanted line is present in the output,
  # and that it comes after any preceding expected lines.
  want_lines.each do |want|
    if !want.empty?
      index = got_lines.index(want)
      # Not found?
      if index.nil?
        raise("Got:\n#{got}\nExpected line not found:\n  #{want}")
      # Not in order?
      elsif index < last_index
        raise("Got:\n#{got}\nExpected line found, but out of order:\n  #{want}")
      else
        last_index = index
      end
    end
  end
end

