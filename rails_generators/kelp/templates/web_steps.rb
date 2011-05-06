# web_steps.rb
#
# This file defines some generic step definitions that utilize the helper
# methods provided by Kelp. It is auto-generated by running:
#
#   script/generate kelp
#
# from a Rails application. It's probably a good idea to avoid editing this
# file, since it may be overwritten by an upgraded kelp gem later. If you
# find any issues with these step definitions and think they can be improved,
# please create an issue on Github:
#
#   http://github.com/wapcaplet/kelp/issues
#

require 'kelp'
World(Kelp::Attribute)
World(Kelp::Checkbox)
World(Kelp::Dropdown)
World(Kelp::Field)
World(Kelp::Helper)
World(Kelp::Navigation)
World(Kelp::Scoping)
World(Kelp::Visibility)


# Patterns shared by step definitions
I = /(?:|I )/
TEXT = /"([^\"]+)"/
REGEX = /\/([^\/]*)\//
WITHIN = /(?: within (.+))?/
ELEMENT = /(?:field|checkbox|dropdown|button)/


# ==========================
# NAVIGATION
# ==========================

# Load a given page path directly. `page_name` may be an absolute path,
# or an expression that is translated to an absolute path by your `path_to`
# function.
#
# Examples:
#
#   Given I am on the home page
#   When I go to my account page
#   And I go to "/logout"
#
Given /^#{I}(am on|go to) (.+)$/ do |page_name|
  visit path_to(page_name)
end


# Press a button on a webpage.
#
# Examples:
#
#   When I press "Delete"
#   And I press "Yes" within "#confirmation"
#
When /^#{I}press #{TEXT}#{WITHIN}$/ do |button, selector|
  press(button, :within => selector)
end


# Click a link in a webpage.
#
# Examples:
#
#   When I follow "List of stuff"
#   And I follow "Next" within "navigation"
#
When /^#{I}follow #{TEXT}#{WITHIN}$/ do |link, selector|
  follow(link, :within => selector)
end


# Click a link in a table row that contains the given text.
# This can be used to click the "Edit" link for a specific record.
#
# Examples:
#
#   When I follow "Edit" next to "John"
#
When /^#{I}follow #{TEXT} next to #{TEXT}$/ do |link, next_to|
  click_link_in_row(link, next_to)
end


# Verify that the current path name matches that of the given page.
#
Then /^#{I}should be on (.+)$/ do |page_name|
  should_be_on_page(page_name)
end


# Verify that the current URL has the given query parameters.
#
# Examples:
#
#   Then I should have the following query string:
#     | fruit | apple |
#     | color | red   |
#
Then /^#{I}should have the following query string:$/ do |expected_pairs|
  should_have_query(expected_pairs.rows_hash)
end


# Save the current page as an HTML file, and open it in your preferred browser.
# Requires that you have the `launchy` gem installed.
Then /^show me the page$/ do
  save_and_open_page
end


# ==========================
# VISIBILITY
# ==========================


# Verify that the given string is visible on the webpage.
#
# Examples:
#
#   Then I should see "Favorite color"
#   But I should not see "Least favorite color"
#
Then /^#{I}should see #{TEXT}#{WITHIN}$/ do |text, selector|
  should_see(text, :within => selector)
end

Then /^#{I}should not see #{TEXT}#{WITHIN}$/ do |text, selector|
  should_not_see(text, :within => selector)
end


# Verify that the given regular expression matches some part of the webpage.
#
# Examples:
#
#   Then I should see /Favorite (color|food)/
#
Then /^#{I}should see #{REGEX}#{WITHIN}$/ do |regexp, selector|
  should_see(Regexp.new(regexp), :within => selector)
end

Then /^#{I}should not see #{REGEX}#{WITHIN}$/ do |regexp, selector|
  should_not_see(Regexp.new(regexp), :within => selector)
end


# Verify the presence or absence of multiple text strings in the page,
# or within a given context.
#
# With `should see`, fails if any of the strings are missing.
# With `should not see`, fails if any of the strings are present.
#
# `items` may be a Cucumber table, or a multi-line string. Examples:
#
#   Then I should see the following:
#     | Apple crumble    |
#     | Banana cream pie |
#     | Cherry tart      |
#
#   Then I should see the following:
#     """
#     Bacon & Eggs
#     Biscuits & Gravy
#     Hash Browns
#     """
#
Then /^#{I}should see(?: the following)?#{WITHIN}:$/ do |selector, items|
  should_see listify(items), :within => selector
end

Then /^#{I}should not see(?: the following)?#{WITHIN}:$/ do |selector, items|
  should_not_see listify(items), :within => selector
end


# Verify that one or more table rows containing the correct values exist (or do
# not exist). Rows do not need to match exactly, and fields do not need to be
# in the same order.
#
# Examples:
#
#   Then I should see table rows containing:
#     | Eric | Edit |
#     | John | Edit |
#   And I should not see a table row containing:
#     | Eric | Delete |
#
Then /^#{I}should see (?:a table row|table rows)#{WITHIN} containing:$/ do |selector, rows|
  rows.raw.each do |fields|
    should_see_in_same_row(fields, :within => selector)
  end
end

Then /^#{I}should not see (?:a table row|table rows)#{WITHIN} containing:$/ do |selector, rows|
  rows.raw.each do |fields|
    should_not_see_in_same_row(fields, :within => selector)
  end
end


# Verify that expected text exists or does not exist in the same row as
# some text. This can be used to ensure the presence or absence of "Edit"
# or "Delete" links, or specific data associated with a row in a table.
#
# Examples:
#
#   Then I should see "Edit" next to "John"
#   And I should not see "Delete" next to "John"
#
Then /^#{I}should see #{TEXT} next to #{TEXT}#{WITHIN}$/ do |text, next_to, selector|
  should_see_in_same_row([text, next_to], :within => selector)
end

Then /^#{I}should not see #{TEXT} next to #{TEXT}#{WITHIN}$/ do |text, next_to, selector|
  should_not_see_in_same_row([text, next_to], :within => selector)
end


# Verify that several expected text strings exist or do not exist in the same
# row as some text. Prevents multiple "should see X next to Y" calls. Similar
# to "should see a row containing", but targeted toward a specific row.
#
# Examples:
#
#   Then I should see the following next to "Terry":
#     | Copy   |
#     | Edit   |
#     | Delete |
#
#   Then I should see the following next to "John":
#     """
#     Copy
#     Edit
#     Delete
#     """
#
Then /^#{I}should see the following next to #{TEXT}#{WITHIN}:$/ do |next_to, selector, items|
  should_see_in_same_row(listify(items) + [next_to], :within => selector)
end

Then /^#{I}should not see the following next to #{TEXT}#{WITHIN}:$/ do |next_to, selector, items|
  should_not_see_in_same_row(listify(items) + [next_to], :within => selector)
end


# Verify that a given button is or isn't visible on the webpage.
#
# Examples:
#
#   Then I should see a "Save" button
#   But I should not see a "Delete" button
#
Then /^#{I}should see a #{TEXT} button#{WITHIN}$/ do |button, selector|
  should_see_button(button, :within => selector)
end

Then /^#{I}should not see a #{TEXT} button#{WITHIN}$/ do |button, selector|
  should_not_see_button(button, :within => selector)
end


# ==========================
# FORMS
# ==========================


# Fill in a form field with a given value.
#
# Examples:
#
#   When I fill in "Favorite color" with "Green"
#
When /^#{I}fill in #{TEXT} with #{TEXT}#{WITHIN}$/ do |field, value, selector|
  fill_in_field(field, value, :within => selector)
end


# Fill in a form field with a given value.
#
# Examples:
#
#   When I fill in "Green" for "Favorite color"
#
When /^#{I}fill in #{TEXT} for #{TEXT}#{WITHIN}$/ do |value, field, selector|
  fill_in_field(field, value, :within => selector)
end


# Fill in multiple form fields from values in a table.
# The fields may be textboxes, dropdowns/listboxes, or checkboxes.
#
# Examples:
#
#   When I fill in the following:
#     | First name  | Alton   |
#     | Last name   | Brown   |
#     | Hair        | blonde  |
#     | Has TV show | checked |
#
When /^#{I}fill in the following#{WITHIN}:$/ do |fields, selector|
  fill_in_fields(fields.rows_hash, :within => selector)
end


# Select a value from a dropdown.
When /^#{I}select #{TEXT} from #{TEXT}$/ do |value, field|
  select value, :from => field
end


# Check a checkbox.
When /^#{I}check #{TEXT}$/ do |field|
  check field
end


# Uncheck a checkbox.
When /^#{I}uncheck #{TEXT}$/ do |field|
  uncheck field
end


# Choose a given radio button.
When /^#{I}choose #{TEXT}$/ do |field|
  choose field
end


# Verify that a given field is empty or nil.
#
# Examples:
#
#   Then the "First name" field should be empty
#
Then /^the #{TEXT} field#{WITHIN} should be empty$/ do |field, selector|
  field_should_be_empty(field, :within => selector)
end


# Verify that a text field in a form does or doesn't contain a value.
#
# Examples:
#
#   Then the "Last name" field should contain "Brown"
#   But the "First name" field should not contain "Leroy"
#
Then /^the #{TEXT} field#{WITHIN} should contain #{TEXT}$/ do |field, selector, value|
  field_should_contain(field, value, :within => selector)
end

Then /^the #{TEXT} field#{WITHIN} should not contain #{TEXT}$/ do |field, selector, value|
  field_should_not_contain(field, value, :within => selector)
end


# Verify that a dropdown has a given value selected. This verifies the visible
# value shown to the user, rather than the value attribute of the selected
# option element.
#
# Examples:
#
#   Then the "Height" dropdown should equal "Average"
#
Then /^the #{TEXT} dropdown#{WITHIN} should equal #{TEXT}$/ do |dropdown, selector, value|
  dropdown_should_equal(dropdown, value, :within => selector)
end


# Verify that a dropdown includes or doesn't include the given value.
#
# Examples:
#
#   Then the "Height" dropdown should include "Tall"
#
Then /^the #{TEXT} dropdown#{WITHIN} should include #{TEXT}$/ do |dropdown, selector, value|
  dropdown_should_include(dropdown, value, :within => selector)
end

Then /^the #{TEXT} dropdown#{WITHIN} should not include #{TEXT}$/ do |dropdown, selector, value|
  dropdown_should_not_include(dropdown, value, :within => selector)
end


# Verify that a dropdown includes or doesn't include all values in the given
# table or multiline string.
#
# Examples:
#
#   Then the "Height" dropdown should include:
#     | Short   |
#     | Average |
#     | Tall    |
#
#   Then the "Favorite Colors" dropdown should include:
#     """
#     Red
#     Green
#     Blue
#     """
#
Then /^the #{TEXT} dropdown#{WITHIN} should include:$/ do |dropdown, selector, values|
  dropdown_should_include(dropdown, listify(values), :within => selector)
end

Then /^the #{TEXT} dropdown#{WITHIN} should not include:$/ do |dropdown, selector, values|
  dropdown_should_not_include(dropdown, listify(values), :within => selector)
end


# Verify multiple fields in a form, optionally restricted to a given selector.
# Fields may be text inputs or dropdowns.
#
# Examples:
#
#   Then the fields should contain:
#     | First name | Eric   |
#     | Last name  | Pierce |
#
Then /^the fields#{WITHIN} should contain:$/ do |selector, fields|
  fields_should_contain_within(selector, fields.rows_hash)
end


# Verify that a checkbox is checked or unchecked.
# "should not be checked" and "should be unchecked" are equivalent, and
# "should be checked" and "should not be unchecked" are equivalent.
#
# Examples:
#
#   Then the "I like apples" checkbox should be checked
#   And the "I like celery" checkbox should not be checked
#
Then /^the #{TEXT} checkbox#{WITHIN} should be (checked|unchecked)$/ do |checkbox, selector, state|
  if state == 'checked'
    checkbox_should_be_checked(checkbox, :within => selector)
  else
    checkbox_should_not_be_checked(checkbox, :within => selector)
  end
end

Then /^the #{TEXT} checkbox#{WITHIN} should not be (checked|unchecked)$/ do |checkbox, selector, state|
  if state == 'unchecked'
    checkbox_should_be_checked(checkbox, :within => selector)
  else
    checkbox_should_not_be_checked(checkbox, :within => selector)
  end
end


# Verify that a checkbox in a certain table row is checked or unchecked.
# "should not be checked" and "should be unchecked" are equivalent, and
# "should be checked" and "should not be unchecked" are equivalent.
#
# Examples:
#
#   Then the "Like" checkbox next to "Apple" should be checked
#   And the "Like" checkbox next to "Banana" should be unchecked
#
Then /^the #{TEXT} checkbox next to #{TEXT}#{WITHIN} should be (checked|unchecked)$/ do |checkbox, next_to, selector, state|

  within(:xpath, xpath_row_containing(next_to)) do
    if state == 'checked'
      checkbox_should_be_checked(checkbox, :within => selector)
    else
      checkbox_should_not_be_checked(checkbox, :within => selector)
    end
  end
end

Then /^the #{TEXT} checkbox next to #{TEXT}#{WITHIN} should not be (checked|unchecked)$/ do |checkbox, next_to, selector, state|

  within(:xpath, xpath_row_containing(next_to)) do
    if state == 'unchecked'
      checkbox_should_be_checked(checkbox, :within => selector)
    else
      checkbox_should_not_be_checked(checkbox, :within => selector)
    end
  end
end


# Attach the filename at the given path to the given form field.
#
# Examples:
#
#   When I attach the file "tmp/my_data.csv" to "CSV file"
#
When /^#{I}attach the file #{TEXT} to #{TEXT}$/ do |path, field|
  attach_file field, File.expand_path(path)
end

