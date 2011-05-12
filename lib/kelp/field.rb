require 'kelp/helper'
require 'kelp/scoping'

module Kelp
  # This module defines helper methods for filling in and verifying the content
  # of fields in a web form.
  #
  module Field
    include Scoping
    include Helper

    # Select a value from a dropdown or listbox, or fill in a text field,
    # depending on what kind of form field is available. If `field` is a
    # dropdown or listbox, select `value` from that; otherwise, assume
    # `field` is a text box.
    #
    # @param [String] field
    #   Capybara locator for the field (name, id, or label text)
    # @param [String] value
    #   Text to select from a dropdown or enter in a text box
    #
    # @raise [Kelp::FieldNotFound]
    #   If no field matching `field` is found
    # @raise [Kelp::OptionNotFound]
    #   If a dropdown matching `field` is found, but it has no
    #   option matching `value`
    #
    # @since 0.1.9
    #
    def select_or_fill(field, value)
      begin
        select(value, :from => field)
      rescue Capybara::ElementNotFound => err
        # The `select` method may raise ElementNotFound in two cases:
        # (1) The given field does not exist, in which case try a text field
        if err.message =~ /no select box with id, name, or label/
          begin
            fill_in(field, :with => value)
          rescue Capybara::ElementNotFound
            raise Kelp::FieldNotFound,
              "No field with id, name, or label '#{field}' found"
          end
        # (2) The field exists, but the value does not
        elsif err.message =~ /no option with text/
          raise Kelp::OptionNotFound,
            "Field '#{field}' has no option '#{value}'"
        # And just in case...
        else
          raise
        end
      end
    end


    # Check a checkbox, select from a dropdown or listbox, or fill in a text
    # field, depending on what kind of form field is available. If value
    # is `checked` or `unchecked`, assume `field` is a checkbox; otherwise,
    # fall back on {#select_or_fill}.
    #
    # @param [String] field
    #   Capybara locator for the field (name, id, or label text)
    # @param [String] value
    #   Text to select from a dropdown or enter in a text box, or
    #   `checked` or `unchecked` to operate on a checkbox
    #
    # @raise [Kelp::Nonexistent]
    #   If no checkbox, dropdown, or text box is found with the given
    #   identifier
    #
    # @since 0.1.9
    #
    def check_or_select_or_fill(field, value)
      # If value is "checked" or "unchecked", assume
      # field is a checkbox
      begin
        if value == "checked"
          check(field)
        elsif value == "unchecked"
          uncheck(field)
        else
          select_or_fill(field, value)
        end
      rescue Capybara::ElementNotFound
        select_or_fill(field, value)
      end
    end


    # Fill in a single field within the scope of a given selector.
    # The field may be a text box, dropdown/listbox, or checkbox.
    # See {#check_or_select_or_fill} for details.
    #
    # @example
    #   fill_in_field "Email", "otto@scratchansniff.wb"
    #   fill_in_field "Send me junk email", "unchecked"
    #
    # @param [String] field
    #   Capybara locator for the field (name, id, or label text)
    # @param [String] value
    #   Text to select from a dropdown or enter in a text box, or
    #   `checked` or `unchecked` to operate on a checkbox
    # @param [Hash] scope
    #   Scoping keywords as understood by {#in_scope}
    #
    # @raise [Kelp::FieldNotFound]
    #   If no field is found matching the given identifier
    #
    def fill_in_field(field, value, scope={})
      in_scope(scope) do
        check_or_select_or_fill(field, value)
      end
    end


    # Fill in multiple fields according to values in a `Hash`.
    # Fields may be text boxes, dropdowns/listboxes, or checkboxes.
    # See {#check_or_select_or_fill} for details.
    #
    # @example
    #   fill_in_fields "First name" => "Otto", "Last name" => "Scratchansniff"
    #   fill_in_fields "phone" => "303-224-7428", :within => "#home"
    #
    # @param [Hash] field_values
    #   "field" => "value" for each field to fill in, select, or check/uncheck
    # @param [Hash] scope
    #   Scoping keywords as understood by {#in_scope}
    #
    # @raise [Kelp::Nonexistent]
    #   If any field could not be found
    #
    def fill_in_fields(field_values, scope={})
      in_scope(scope) do
        field_values.each do |field, value|
          check_or_select_or_fill(field, value)
        end
      end
    end


    # Fill in multiple fields within the scope of a given selector.
    # Alias for:
    #
    #   fill_in_fields fields, :within => selector
    #
    def fill_in_fields_within(selector, fields)
      fill_in_fields fields, :within => selector
    end


    # Fill in a single fields within the scope of a given selector.
    # Alias for:
    #
    #   fill_in_field field, value, :within => selector
    #
    def fill_in_field_within(selector, field, value)
      fill_in_field field, value, :within => selector
    end


    # Verify that the given field is empty or nil.
    #
    # @param [String] field
    #   Capybara locator for the field (name, id, or label text)
    # @param [Hash] scope
    #   Scoping keywords as understood by {#in_scope}
    #
    # @raise [Kelp::Unexpected]
    #   If the given field is not empty or nil
    #
    def field_should_be_empty(field, scope={})
      in_scope(scope) do
        _field = nice_find_field(field)
        if !(_field.nil? || _field.value.nil? || _field.value == '')
          raise Kelp::Unexpected,
            "Expected field '#{field}' to be empty, but value is '#{_field.value}'"
        end
      end
    end


    # Return the string value found in the given field.
    # If the field is `nil`, return the empty string.
    #
    # @param [String] field
    #   Capybara locator for the field (name, id, or label text)
    #
    # @return [String]
    #   The value found in the given field
    #
    # @since 0.2.1
    #
    def field_value(field)
      element = find_field(field)
      value = (element.tag_name == 'textarea') ? element.text : element.value
      # If field value is an Array, take the first item
      if value.class == Array
        value = value.first
      end
      return value.to_s
    end


    # Verify that the given field contains the given value.
    #
    # @param [String] field
    #   Capybara locator for the field (name, id, or label text)
    # @param [String] value
    #   Value you expect to see in the text field
    # @param [Hash] scope
    #   Scoping keywords as understood by {#in_scope}
    #
    # @raise [Kelp::Unexpected]
    #   If the given field does not contain `value`
    #
    def field_should_contain(field, value, scope={})
      in_scope(scope) do
        actual = field_value(field)
        # Escape any problematic characters in the expected value
        expect = Regexp.escape(value)
        # Match actual to expected
        if !(actual =~ /#{expect}/)
          raise Kelp::Unexpected,
            "Expected '#{field}' to contain '#{expect}'" + \
            "\nGot '#{actual}'"
        end
      end
    end


    # Verify that the given field does not contain the given value.
    #
    # @param [String] field
    #   Capybara locator for the field (name, id, or label text)
    # @param [String] value
    #   Value you expect to not see in the text field
    # @param [Hash] scope
    #   Scoping keywords as understood by {#in_scope}
    #
    # @raise [Kelp::Unexpected]
    #   If the given field contains `value`
    #
    def field_should_not_contain(field, value, scope={})
      in_scope(scope) do
        actual = field_value(field)
        # Escape any problematic characters in the expected value
        expect_not = Regexp.escape(value)
        # Match actual to expected
        if (actual =~ /#{expect_not}/)
          raise Kelp::Unexpected,
            "Did not expect '#{field}' to contain '#{expect_not}'" + \
            "\nGot '#{actual}'"
        end
      end
    end


    # Verify the values of multiple fields given as a Hash.
    #
    # @param [Hash] field_values
    #   "field" => "value" for each field you want to verify
    # @param [Hash] scope
    #   Scoping keywords as understood by {#in_scope}
    #
    # @raise [Kelp::Unexpected]
    #   If any field does not contain the expected value
    #
    def fields_should_contain(field_values, scope={})
      in_scope(scope) do
        field_values.each do |field, value|
          _field = find_field(field)
          # For nil/empty, check for nil field or nil value
          if value.nil? or value.empty?
            field_should_be_empty(field)
          # If field is a dropdown
          elsif _field.tag_name == 'select'
            dropdown_should_equal(field, value)
          # Otherwise treat as a text field
          else
            field_should_contain(field, value)
          end
        end
      end
    end


    # Verify a single field within the scope of a given selector.
    # Alias for:
    #
    #   field_should_contain field, value, :within => selector
    #
    def field_should_contain_within(selector, field, value)
      field_should_contain field, value, :within => selector
    end


    # Verify fields within the scope of a given selector.
    # Alias for:
    #
    #   fields_should_contain field_values, :within => selector
    #
    def fields_should_contain_within(selector, field_values)
      fields_should_contain field_values, :within => selector
    end

  end
end
