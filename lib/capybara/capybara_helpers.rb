# web_helpers.rb
# Generic helper methods for website navigation and testing


module XPathHelper
  # Return an XPath for any table row containing all strings in +texts+.
  def xpath_row_containing(texts)
    texts = [texts] if texts.class == String
    conditions = texts.collect do |text|
      "contains(., '#{text}')"
    end.join(' and ')
    return "//table//tr[#{conditions}]"
  end

  # Return an XPath scope restricted to following siblings of elements
  # containing +text+.
  def xpath_after(text)
    text ? "//*[contains(.,'#{text}')]/following-sibling::*" : "//*"
  end

  # Return an XPath scope restricted to preceding siblings of elements
  # containing +text+.
  def xpath_before(text)
    text ? "//*[contains(.,'#{text}')]/preceding-sibling-sibling::*" : "//*"
  end
end


module CapybaraHelper
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

  # Execute a block of code within a given scope.
  # +locator+ may be in css or xpath form, depending on what type
  # is set in Capybara.default_locator.
  def with_scope(locator)
    locator ? within(locator) { yield } : yield
  end

  # Execute a block of code inside a given scope. The +scope+ Hash
  # may include any or all of the following:
  #
  #   :within => locator    within the given selector
  #   :after => 'text'      following-siblings of 'text'
  #   :before => 'text'     preceding-siblings of 'text'
  #
  def in_scope(scope={})
    within(:xpath, xpath_after(scope[:after])) do
      within(:xpath, xpath_before(scope[:before])) do
        with_scope(scope[:within]) do
          yield
        end
      end
    end
  end
end

module WebHelper
  # Verify the presence of one or more text strings.
  # Scope may be defined per the #in_scope method.
  def should_see(texts, scope={})
    texts = [texts] if texts.class == String
    in_scope(scope) do
      texts.each do |text|
        page.should have_content(text)
      end
    end
  end

  # Verify the absence of one or more text strings.
  # Scope may be defined per the #in_scope method.
  def should_not_see(texts, scope={})
    texts = [texts] if texts.class == String
    in_scope(scope) do
      texts.each do |text|
        page.should have_no_content(text)
      end
    end
  end

  # Follow a link.
  # Scope may be defined per the #in_scope method.
  def follow(link, scope={})
    in_scope(scope) do
      click_link(link)
    end
  end

  # Press a button.
  # Scope may be defined per the #in_scope method.
  def press(button, scope={})
    in_scope(scope) do
      click_button(button)
    end
  end

  # Verify that a table row exists containing all the given text strings.
  def should_see_in_same_row(texts)
    page.should have_xpath(xpath_row_containing(texts))
  end

  # Verify that a table row does NOT exist containing all the given text strings.
  def should_not_see_in_same_row(texts)
    page.should have_no_xpath(xpath_row_containing(texts))
  end

  # Click a link in a table row containing the given text.
  def click_link_in_row(link, text)
    row = find(:xpath, xpath_row_containing([link, text]))
    row.click_link(link)
  end

  # Ensure that the element with the given HTML id is disabled.
  def element_should_be_disabled(element_id)
    page.should have_xpath("//*[@id='#{element_id}']")
    page.should have_xpath("//*[@id='#{element_id}' and @disabled]")
  end

  # Ensure that the element with the given HTML id is enabled.
  def element_should_be_enabled(element_id)
    page.should have_xpath("//*[@id='#{element_id}']")
    page.should have_no_xpath("//*[@id='#{element_id}' and @disabled]")
  end
end


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
    _field.nil? || _field.value.nil?
  end

  # Verify that the selected option in a dropdown has the given
  # value. Note that this is the *visible* content of the dropdown
  # (the content of the <option> element), rather than the
  # 'value' attribute of the option.
  def dropdown_should_contain(dropdown, value)
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
  def dropdown_value_should_contain(dropdown, value)
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
          dropdown_should_contain(field, value)
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

  # Verify that the given field contains a given day's date in the given format.
  def field_should_contain_date(field, day, format='%Y-%m-%d')
    date_string = parse_date(day).strftime(format)
    field_should_contain(field, date_string)
  end

  # Enter text in a tinymce editor widget. +iframe_id+ is the
  # HTML id of the +iframe+ element containing the editor.
  def fill_in_tinymce(iframe_id, text)
    within_frame(iframe_id) do
      editor = page.find_by_id('tinymce').native
      editor.send_keys(text)
    end
  end
end

# Add all helpers to Cucumber's world
World(CapybaraHelper)
World(XPathHelper)
World(WebHelper)
World(FormHelper)

