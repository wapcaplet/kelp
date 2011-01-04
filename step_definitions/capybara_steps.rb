
require 'uri'
require 'cgi'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))
#require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "selectors"))

# Single-line step scoper
When /^(.*) within ([^:]+)$/ do |step, parent|
  scope_within(parent) { When step }
end

# Multi-line step scoper
When /^(.*) within ([^:]+):$/ do |step, parent, table_or_string|
  scope_within(parent) { When "#{step}:", table_or_string }
end

Given /^(?:|I )am on (.+)$/ do |page_name|
  visit path_to(page_name)
end

When /^(?:|I )go to (.+)$/ do |page_name|
  visit path_to(page_name)
end

When /^(?:|I )press "([^"]*)"$/ do |button|
  click_button button
end

When /^(?:|I )follow "([^"]*)"$/ do |link|
  click_link link
end

When /^(?:|I )fill in "([^"]*)" with "([^"]*)"$/ do |field, value|
  fill_in field, :with => value
end

When /^(?:|I )fill in "([^"]*)" for "([^"]*)"$/ do |value, field|
  fill_in field, :with => value
end

# Use this to fill in an entire form with data from a table. Example:
#
#   When I fill in the following:
#     | Account Number | 5002       |
#     | Expiry date    | 2009-11-01 |
#     | Note           | Nice guy   |
#     | Wants Email?   |            |
#
# TODO: Add support for checkbox, select og option
# based on naming conventions.
#
When /^(?:|I )fill in the following:$/ do |fields|
  fill_in_fields fields.rows_hash
end

When /^(?:|I )select "([^"]*)" from "([^"]*)"$/ do |value, field|
  select value, :from => field
end

When /^(?:|I )check "([^"]*)"$/ do |field|
  check field
end

When /^(?:|I )uncheck "([^"]*)"$/ do |field|
  uncheck field
end

When /^(?:|I )choose "([^"]*)"$/ do |field|
  choose field
end

When /^(?:|I )attach the file "([^"]*)" to "([^"]*)"$/ do |path, field|
  attach_file field, File.expand_path(path)
end

Then /^(?:|I )should see "([^"]*)"$/ do |text|
  should_see text
end

Then /^(?:|I )should see \/([^\/]*)\/$/ do |regexp|
  should_see Regexp.new(regexp)
end

Then /^(?:|I )should not see "([^"]*)"$/ do |text|
  should_not_see text
end

Then /^(?:|I )should not see \/([^\/]*)\/$/ do |regexp|
  should_not_see Regexp.new(regexp)
end

Then /^the "([^"]*)" field(?: within (.*))? should contain "([^"]*)"$/ do |field, parent, value|
  field_should_contain field, value, :within => parent
end

Then /^the "([^"]*)" field(?: within (.*))? should not contain "([^"]*)"$/ do |field, parent, value|
  field_should_not_contain field, value, :within => parent
end

Then /^the "([^"]*)" checkbox(?: within (.*))? should be checked$/ do |label, parent|
  checkbox_should_be_checked label, :within => parent
end

Then /^the "([^"]*)" checkbox(?: within (.*))? should not be checked$/ do |label, parent|
  checkbox_should_not_be_checked label, :within => parent
end

Then /^(?:|I )should be on (.+)$/ do |page_name|
  current_path = URI.parse(current_url).path
  if current_path.respond_to? :should
    current_path.should == path_to(page_name)
  else
    assert_equal path_to(page_name), current_path
  end
end

Then /^(?:|I )should have the following query string:$/ do |expected_pairs|
  query = URI.parse(current_url).query
  actual_params = query ? CGI.parse(query) : {}
  expected_params = {}
  expected_pairs.rows_hash.each_pair{|k,v| expected_params[k] = v.split(',')}

  if actual_params.respond_to? :should
    actual_params.should == expected_params
  else
    assert_equal expected_params, actual_params
  end
end

Then /^show me the page$/ do
  save_and_open_page
end
