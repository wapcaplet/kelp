
module WebHelper
  # Execute a block of code within a given scope.
  # +locator+ may be in css or xpath form, depending on what type
  # is set in Capybara.default_locator.
  def scope_within(locator)
    if locator
      within(locator) do
        yield
      end
    else
      yield
    end
  end

  # Execute a block of code inside a given scope. The +scope+ Hash
  # may include:
  #
  #   :within => locator    within the given selector
  #
  # Other scopes such as :before, :after and so on may be supported later
  def in_scope(scope)
    scope_within(scope[:within]) do
      yield
    end
  end

  # Verify the presence of one or more text strings.
  # Scope may be defined per the #in_scope method.
  def should_see(texts, scope={})
    texts = [texts] if (texts.class == String || texts.class == Regexp)
    in_scope(scope) do
      texts.each do |text|
        page_should_have text
      end
    end
  end

  # Verify the absence of one or more text strings.
  # Scope may be defined per the #in_scope method.
  def should_not_see(texts, scope={})
    texts = [texts] if (texts.class == String || texts.class == Regexp)
    in_scope(scope) do
      texts.each do |text|
        page_should_not_have text
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
  def should_be_disabled(element_id)
    page.should have_xpath("//*[@id='#{element_id}']")
    page.should have_xpath("//*[@id='#{element_id}' and @disabled]")
  end

  # Ensure that the element with the given HTML id is enabled.
  def should_be_enabled(element_id)
    page.should have_xpath("//*[@id='#{element_id}']")
    page.should have_no_xpath("//*[@id='#{element_id}' and @disabled]")
  end

  # Ensure that the current page content includes a String or Regexp.
  def page_should_have(text_or_regexp)
    if text_or_regexp.class == String
      if page.respond_to? :should
        page.should have_content(text_or_regexp)
      else
        assert page.has_content?(text_or_regexp)
      end
    elsif text_or_regexp.class == Regexp
      if page.respond_to? :should
        page.should have_xpath('.//*', :text => text_or_regexp)
      else
        assert page.has_xpath?('.//*', :text => text_or_regexp)
      end
    else
      raise "Expected String or Regexp, got #{text_or_regexp.class}"
    end
  end

  # Ensure that the current page content does not include a String or Regexp.
  def page_should_not_have(text_or_regexp)
    if text_or_regexp.class == String
      if page.respond_to? :should
        page.should have_no_content(text_or_regexp)
      else
        assert page.has_no_content?(text_or_regexp)
      end
    elsif text_or_regexp.class == Regexp
      if page.respond_to? :should
        page.should have_no_xpath('.//*', :text => text_or_regexp)
      else
        assert page.has_no_xpath?('.//*', :text => text_or_regexp)
      end
    else
      raise "Expected String or Regexp, got #{text_or_regexp.class}"
    end
  end


  private

  # Return an XPath for any table row containing all strings in +texts+.
  def xpath_row_containing(texts)
    texts = [texts] if texts.class == String
    conditions = texts.collect do |text|
      "contains(., '#{text}')"
    end.join(' and ')
    return "//table//tr[#{conditions}]"
  end

end

# TODO: Put this in a generator
#World(WebHelper)

