# kelp_steps.rb
#
# This file defines some generic step definitions that utilize the helper
# methods provided by Kelp.

require 'kelp'
World(Kelp::Visibility)
World(Kelp::Dropdown)

SHOULD_OR_NOT = /(should|should not)/
WITHIN = /(?: within "(.+)")?/

# Verify the presence or absence of multiple text strings in the page,
# or within a given context.
#
# With `should see`, fails if any of the strings are missing.
# With `should not see`, fails if any of the strings are present.
#
# `items` may be a Cucumber table, or a multi-line string. Examples:
#
#   Then I should see the following:
#     | First thing |
#     | Next thing |
#     | Last thing |
#
#   Then I should see the following:
#     """
#     First thing
#     Next thing
#     Last thing
#     """
#
Then /^I #{SHOULD_OR_NOT} see the following#{WITHIN}:$/ do |expect, within, items|
  if strings.class == Cucumber::Ast::Table
    strings = items.raw.flatten
  else
    strings = items.split("\n")
  end
  if expect == 'should'
    should_see strings, :within => within
  else
    should_not_see strings, :within => within
  end
end


# Verify that one or more table rows containing the correct values exist (or do
# not exist). Rows do not need to match exactly, and fields do not need to be
# in the same order.
Then /^I #{SHOULD_OR_NOT} see (?:a table row|table rows)#{WITHIN} containing:$/ do |expect, within, rows|
  rows.raw.each do |fields|
    if expect == 'should'
      should_see_in_same_row(fields, :within => within)
    else
      should_not_see_in_same_row(fields, :within => within)
    end
  end
end


# Verify that a dropdown has a given value selected. This verifies the visible
# value shown to the user, rather than the value attribute of the selected
# option element.
Then /^the "(.+)" dropdown#{WITHIN} should equal "(.+)"$/ do |dropdown, within, value|
  dropdown_should_equal(dropdown, value, :within => within)
end


# Verify that a dropdown includes or doesn't include the given value.
Then /^the "(.+)" dropdown#{WITHIN} #{SHOULD_OR_NOT} include "(.+)"$/ do |dropdown, within, expect, value|
  if expect == 'should'
    dropdown_should_include(dropdown, value, :within => within)
  else
    dropdown_should_not_include(dropdown, value, :within => within)
  end
end


# Verify that a dropdown includes or doesn't include all values in the given table.
Then /^the "(.+)" dropdown#{WITHIN} #{SHOULD_OR_NOT} include:$/ do |dropdown, within, expect, values|
  values.raw.flatten.each do |value|
    if expect == 'should'
      dropdown_should_include(dropdown, value, :within => within)
    else
      dropdown_should_not_include(dropdown, value, :within => within)
    end
  end
end


# Verify that a given field is empty or nil
Then /^the "(.+)" field#{WITHIN} should be empty$/ do |field, within|
  with_scope(within) do
    field_should_be_empty field
  end
end


# Verify multiple fields in a form, optionally restricted to a given selector.
# Fields may be text inputs or dropdowns
Then /^the fields#{WITHIN} should contain:$/ do |within, fields|
  fields_should_contain_within(within, fields.rows_hash)
end


# Verify that expected text exists or does not exist in the same row as
# identifier text. This can be used to ensure the presence or absence of "Edit"
# or "Delete" links, or specific data associated with a row in a table.
Then /^I #{SHOULD_OR_NOT} see "(.+)" next to "(.+)"$/ do |expect, expected, identifier|
  if expect = 'should'
    should_see_in_same_row [expected, identifier]
  else
    should_not_see_in_same_row [expected, identifier]
  end
end


# Click a link in a table row that contains the given text.
# This can be used to click the "Edit" link for a specific record.
When /^I follow "(.+)" next to "(.+)"$/ do |link, identifier|
  click_link_in_row(link, identifier)
end

