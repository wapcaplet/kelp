require 'kelp/helper'

module FormHelper
  # Fill in multiple fields according to values in a Hash.
  # Scope may be defined per the #in_scope method.
  def fill_in_fields(fields, scope={})
    in_scope(scope) do
      fields.each do |name, value|
        fill_in name, :with => value
      end
    end
  end

  # Fill in multiple fields within the scope of a given selector.
  # Syntactic sugar for #fill_in_fields.
  def fill_in_fields_within(selector, fields)
    fill_in_fields fields, :within => selector
  end

  # Verify that the given field is empty or nil.
  def field_should_be_empty(field)
    _field = nice_find_field(field)
    if _field.nil? || _field.value.nil?
      return true
    else
      raise "Expected field '#{field}' to be empty, but it has a value '#{_field.value}'"
    end
  end

  # Verify that the selected option in a dropdown has the given
  # value. Note that this is the *visible* content of the dropdown
  # (the content of the <option> element), rather than the
  # 'value' attribute of the option.
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

  # Verify that a given dropdown includes all of the given values. Search
  # first by the 'value' attribute, then by the content of each option; if
  # values are not found in either place, an error occurs.
  # Scope may be defined per the #in_scope method.
  def dropdown_should_include(dropdown, values, scope={})
    in_scope(scope) do
      # If values is a String, convert it to an Array
      values = [values] if values.class == String

      field = nice_find_field(dropdown)
      # Look for each value
      values.each do |value|
        begin
          option = field.find(:xpath, ".//option[@value='#{value}']")
        rescue Capybara::ElementNotFound
          option = field.find(:xpath, ".//option[contains(., '#{value}')]")
        end
      end
    end
  end

  # Verify that the given <select> element has a given value selected. Works
  # with single- or multi-select elements. This verifies the 'value' attribute
  # of the selected option, rather than its visible content.
  def dropdown_value_should_equal(dropdown, value)
    # FIXME: When this returns False, does that fail the step?
    field = find_field(dropdown)
    field.value.should include(value)
  end

  # Verify that the given field contains the given value.
  def field_should_contain(field, value)
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

  # Verify the values of multiple fields given as a Hash.
  # Scope may be defined per the #in_scope method.
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

  # Verify fields within the scope of a given selector.
  # Syntactic sugar for #fields_should_contain.
  def fields_should_contain_within(selector, field_values)
    fields_should_contain field_values, :within => selector
  end

  private

  # A slightly friendlier version of Capybara's +find_field+, which actually
  # tells you which locator failed to match (instead of giving a useless
  # Unable to find '#<XPath::Union:0xXXXXXXX>' message).
  def nice_find_field(locator)
    begin
      field = find_field(locator)
    rescue Capybara::ElementNotFound
      raise "Could not find field with locator: '#{locator}'"
    end
  end
end

