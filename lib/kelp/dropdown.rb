require 'kelp/scoping'
require 'kelp/helper'

module Kelp
  # This module defines methods for working with dropdown fields in a web form,
  # including verifying their visible content as well as the `value` attribute
  # of selected options.
  #
  module Dropdown
    include Scoping
    include Helper

    # Verify that the selected option in a dropdown has the given
    # value. Note that this is the *visible* content of the dropdown
    # (the content of the <option> element), rather than the
    # 'value' attribute of the option.
    #
    # @param [String] dropdown
    #   Capybara locator for the dropdown (the `select` element)
    # @param [String] value
    #   Value you expect to see as the currently-selected option
    # @param [Hash] scope
    #   Scoping keywords as understood by {#in_scope}
    #
    # @raise [Kelp::Unexpected]
    #   If the given dropdown does not equal `value`
    #
    def dropdown_should_equal(dropdown, value, scope={})
      in_scope(scope) do
        field = nice_find_field(dropdown)
        # See if there's a 'selected' option
        begin
          selected = field.find(:xpath, ".//option[@selected='selected']")
        # If not, find the option matching the field's 'value' attribute
        rescue Capybara::ElementNotFound
          # FIXME: Find a way to support multiple-selection dropdowns
          if field.value.class == Array
            raise Exception, "Multiple-selection dropdowns are not supported"
          end
          field_value = xpath_sanitize(field.value)
          selected = field.find(:xpath, ".//option[@value=#{field_value}]")
        end
        if selected.text != value
          raise Kelp::Unexpected,
            "Expected '#{dropdown}' dropdown to equal '#{value}'\nGot '#{selected.text}' instead"
        end
      end
    end


    # Verify that a given dropdown includes all of the given strings.
    # This looks for the visible values in the dropdown, *not* the 'value'
    # attribute of each option.
    #
    # @example
    #   dropdown_should_include "Weekday", "Monday"
    #   dropdown_should_include "Size", ["Small", "Medium", "Large"]
    #
    # @param [String] dropdown
    #   Capybara locator for the dropdown (the `select` element)
    # @param [Array] values
    #   Visible contents you expect to be able to select from the dropdown
    # @param [Hash] scope
    #   Scoping keywords as understood by {#in_scope}
    #
    # @raise [Kelp::Unexpected]
    #   If the given dropdown does not include all `values`
    #
    def dropdown_should_include(dropdown, values, scope={})
      in_scope(scope) do
        # If values is a String, convert it to an Array
        values = [values] if values.class == String
        field = nice_find_field(dropdown)
        # Select all expected values that don't appear in the dropdown
        unexpected = values.select do |value|
          !page.has_xpath?(".//option[text()=#{xpath_sanitize(value)}]")
        end
        if !unexpected.empty?
          raise Kelp::Unexpected,
            "Expected '#{dropdown}' dropdown to include: #{values.inspect}" + \
            "\nMissing: #{unexpected.inspect}"
        end
      end
    end


    # Verify that a given dropdown does not include any of the given strings.
    # This looks for the visible values in the dropdown, *not* the 'value'
    # attribute of each option.
    #
    # @param [String] dropdown
    #   Capybara locator for the dropdown (the `select` element)
    # @param [Array] values
    #   Visible contents you do not want to see in the dropdown
    # @param [Hash] scope
    #   Scoping keywords as understood by {#in_scope}
    #
    # @raise [Kelp::Unexpected]
    #   If the given dropdown includes any value in `values`
    #
    # @since 0.1.2
    #
    def dropdown_should_not_include(dropdown, values, scope={})
      in_scope(scope) do
        # If values is a String, convert it to an Array
        values = [values] if values.class == String
        field = nice_find_field(dropdown)
        # Select all not-expected values that do appear in the dropdown
        unexpected = values.select do |value|
          page.has_xpath?(".//option[text()=#{xpath_sanitize(value)}]")
        end
        if !unexpected.empty?
          raise Kelp::Unexpected,
            "Expected '#{dropdown}' dropdown to not include: #{values.inspect}" + \
            "\nDid include: #{unexpected.inspect}"
        end
      end
    end


    # Verify that a dropdown currently has the option with the given `value`
    # attribute selected. Note that this differs from {#dropdown_should_equal},
    # in that it looks at the actual `value` attribute of the selected option,
    # rather than its visible contents.
    #
    # @param [String] dropdown
    #   Capybara locator for the dropdown (the `select` element)
    # @param [String] value
    #   Expected `value` attribute of the selected `option`
    #
    # @raise [Kelp::Unexpected]
    #   If the given dropdown's 'value' attribute is not equal to `value`
    #
    def dropdown_value_should_equal(dropdown, value)
      field = find_field(dropdown)
      if field.value != value
        raise Kelp::Unexpected,
          "Expected '#{dropdown}' dropdown's value to equal '#{value}'" + \
          "\nGot '#{field.value}' instead"
      end
    end

  end
end
