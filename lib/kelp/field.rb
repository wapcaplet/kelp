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
    # @since 0.1.9
    #
    # @param [String] field
    #   Capybara locator for the field (name, id, or label text)
    # @param [String] value
    #   Text to select from a dropdown or enter in a text box
    #
    def select_or_fill(field, value)
      begin
        select(value, :from => field)
      rescue
        fill_in(field, :with => value)
      end
    end


    # Check a checkbox, select from a dropdown or listbox, or fill in a text
    # field, depending on what kind of form field is available. If value
    # is `checked` or `unchecked`, assume `field` is a checkbox; otherwise,
    # fall back on {#select_or_fill}.
    #
    # @since 0.1.9
    #
    # @param [String] field
    #   Capybara locator for the field (name, id, or label text)
    # @param [String] value
    #   Text to select from a dropdown or enter in a text box, or
    #   `checked` or `unchecked` to operate on a checkbox
    #
    def check_or_select_or_fill(field, value)
      # If value is "checked" or "unchecked", assume
      # field is a checkbox
      if value == "checked"
        begin
          check(field)
        rescue
          select_or_fill(field, value)
        end
      elsif value == "unchecked"
        begin
          uncheck(field)
        rescue
          select_or_fill(field, value)
        end
      else
        select_or_fill(field, value)
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
    def fill_in_fields(field_values, scope={})
      in_scope(scope) do
        field_values.each do |field, value|
          check_or_select_or_fill(field, value)
        end
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
    def fill_in_field(field, value, scope={})
      fields = {field => value}
      fill_in_fields fields, scope
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
    def field_should_be_empty(field, scope={})
      in_scope(scope) do
        _field = nice_find_field(field)
        if !(_field.nil? || _field.value.nil? || _field.value == '')
          raise RuntimeError, "Expected field '#{field}' to be empty, but value is '#{_field.value}'"
        end
      end
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
    def field_should_contain(field, value, scope={})
      in_scope(scope) do
        # TODO: Make this work equally well with any kind of field
        # (text, single-select, multi-select)
        field = find_field(field)
        field_value = (field.tag_name == 'textarea') ? field.text : field.value
        # If field value is an Array, take the first item
        if field_value.class == Array
          field_value = field_value.first
        end
        # Escape any problematic characters in the expected value
        value = Regexp.escape(value)
        # Match actual to expected
        if field_value.respond_to? :should
          field_value.should =~ /#{value}/
        else
          assert_match(/#{value}/, field_value)
        end
      end
    end


    def field_should_not_contain(field, value, scope={})
      raise "Not implemented yet"
      #with_scope(parent) do
        #field = find_field(field)
        #field_value = (field.tag_name == 'textarea') ? field.text : field.value
        #if field_value.respond_to? :should_not
          #field_value.should_not =~ /#{value}/
        #else
          #assert_no_match(/#{value}/, field_value)
        #end
      #end
    end


    # Verify the values of multiple fields given as a Hash.
    #
    # @param [Hash] field_values
    #   "field" => "value" for each field you want to verify
    # @param [Hash] scope
    #   Scoping keywords as understood by {#in_scope}
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
