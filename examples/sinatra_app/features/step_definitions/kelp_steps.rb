# kelp_steps.rb
#
# This file defines some generic step definitions that utilize the helper
# methods provided by Kelp.

require 'kelp'
World(Kelp::Visibility)

# Verify the presence or absence of multiple text strings in a table.
Then /^I (should|should not) see the following(?: within "(.+)")?:$/ do |expect, selector, fields|
  if expect == 'should'
    should_see fields.raw.flatten, :within => selector
  else
    should_not_see fields.raw.flatten, :within => selector
  end
end


# Verify that one or more table rows containing the correct values exist (or do
# not exist). Rows do not need to match exactly, and fields do not need to be
# in the same order.
Then /^I (should|should not) see (?:a table row|table rows)(?: within "(.+)")? containing:$/ do |expect, selector, rows|
  rows.raw.each do |fields|
    if expect == 'should'
      should_see_in_same_row(fields)
    else
      should_not_see_in_same_row(fields)
    end
  end
end


# Verify that a dropdown has a given value selected. This verifies the visible
# value shown to the user, rather than the value attribute of the selected
# option element.
Then /^the "(.+)" dropdown(?: within "(.+)")? should contain "(.+)"$/ do |dropdown, selector, value|
  with_scope(selector) do
    dropdown_should_equal(dropdown, value)
  end
end


# Verify that a given field is empty or nil
Then /^the "(.+)" field(?: within "(.+)")? should be empty$/ do |field, selector|
  with_scope(selector) do
    field_should_be_empty field
  end
end


# Verify multiple fields in a form, optionally restricted to a given selector.
# Fields may be text inputs or dropdowns
Then /^the fields(?: within "(.+)")? should contain:$/ do |selector, fields|
  fields_should_contain_within(selector, fields.rows_hash)
end


# Verify that expected text exists or does not exist in the same row as
# identifier text. This can be used to ensure the presence or absence of "Edit"
# or "Delete" links, or specific data associated with a row in a table.
Then /^I (should|should not) see "(.+)" next to "(.+)"$/ do |expect, expected, identifier|
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

