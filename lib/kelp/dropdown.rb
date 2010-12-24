require 'kelp/scoping'
require 'kelp/helper'

module Kelp
  module Dropdown
    include Scoping
    include Helper

    # Verify that the selected option in a dropdown has the given
    # value. Note that this is the *visible* content of the dropdown
    # (the content of the <option> element), rather than the
    # 'value' attribute of the option.
    #
    # @param [String] dropdown
    #   Capybara locator for the dropdown (the +select+ element)
    # @param [String] value
    #   Value you expect to see as the currently-selected option
    #
    def dropdown_should_equal(dropdown, value)
      field = nice_find_field(dropdown)
      # See if there's a 'selected' option
      begin
        selected = field.find(:xpath, ".//option[@selected='selected']")
      # If not, find the option matching the first field value
      rescue Capybara::ElementNotFound
        selected = field.find(:xpath, ".//option[@value='#{field.value.first}']")
      end
      selected.text.should =~ /#{value}/
    end


    # Verify that a given dropdown includes all of the given strings.
    # This looks for the visible values in the dropdown, *not* the 'value'
    # attribute of each option.
    #
    # @param [String] dropdown
    #   Capybara locator for the dropdown (the +select+ element)
    # @param [Array] values
    #   Visible contents you expect to be able to select from the dropdown
    # @param [Hash] scope
    #   Scoping keywords as understood by WebHelper#in_scope
    #
    def dropdown_should_include(dropdown, values, scope={})
      in_scope(scope) do
        # If values is a String, convert it to an Array
        values = [values] if values.class == String

        field = nice_find_field(dropdown)
        # Look for each value
        values.each do |value|
          page.should have_xpath(".//option[text()='#{value}']")
          #page.should have_xpath(".//option[contains(., '#{value}')]")
        end
      end
    end


    # Verify that a given dropdown does not include any of the given strings.
    # This looks for the visible values in the dropdown, *not* the 'value'
    # attribute of each option.
    #
    # @param [String] dropdown
    #   Capybara locator for the dropdown (the +select+ element)
    # @param [Array] values
    #   Visible contents you do not want to see in the dropdown
    # @param [Hash] scope
    #   Scoping keywords as understood by WebHelper#in_scope
    #
    def dropdown_should_not_include(dropdown, values, scope={})
      in_scope(scope) do
        # If values is a String, convert it to an Array
        values = [values] if values.class == String

        field = nice_find_field(dropdown)
        # Look for each value
        values.each do |value|
          page.should have_no_xpath(".//option[text()='#{value}']")
        end
      end
    end


    # Verify that a dropdown currently has the option with the given +value+
    # attribute selected. Note that this differs from {#dropdown_should_equal},
    # in that it looks at the actual +value+ attribute of the selected option,
    # rather than its visible contents.
    #
    # @param [String] dropdown
    #   Capybara locator for the dropdown (the +select+ element)
    # @param [String] value
    #   Expected +value+ attribute of the selected +option+
    #
    def dropdown_value_should_equal(dropdown, value)
      # FIXME: When this returns False, does that fail the step?
      field = find_field(dropdown)
      field.value.should include(value)
    end

  end
end
