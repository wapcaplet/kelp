require 'kelp/helper'
require 'kelp/scoping'

module Kelp
  # This module defines helper methods for filling in and verifying the content
  # of fields in a web form.
  #
  module Field
    include Scoping
    include Helper

    # Fill in multiple fields according to values in a `Hash`.
    #
    # @example
    #   fill_in_fields "First name" => "Otto", "Last name" => "Scratchansniff"
    #   fill_in_fields "phone" => "303-224-7428", :within => "#home"
    #
    # @param [Hash] fields
    #   "field" => "value" for each field to fill in
    # @param [Hash] scope
    #   Scoping keywords as understood by {#in_scope}
    #
    def fill_in_fields(fields, scope={})
      in_scope(scope) do
        fields.each do |name, value|
          fill_in name, :with => value
        end
      end
    end


    # Fill in a single field within the scope of a given selector.
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
    def field_should_be_empty(field)
      _field = nice_find_field(field)
      if _field.nil? || _field.value.nil?
        return true
      else
        raise RuntimeError, "Expected field '#{field}' to be empty, but value is '#{_field.value}'"
      end
    end


    # Verify that the given field contains the given value.
    #
    # @param [String] field
    #   Capybara locator for the field (name, id, or label text)
    # @param [String] value
    #   Value you expect to see in the text field
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
