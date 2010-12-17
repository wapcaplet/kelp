# Functions that are identical for both Webrat and Capybara
module Helper
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
        page_should_contain text
      end
    end
  end

  # Verify the absence of one or more text strings.
  # Scope may be defined per the #in_scope method.
  def should_not_see(texts, scope={})
    texts = [texts] if (texts.class == String || texts.class == Regexp)
    in_scope(scope) do
      texts.each do |text|
        page_should_not_contain text
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

  # Ensure that the current page content includes a String or Regexp.
  def page_should_contain(text_or_regexp)
    if text_or_regexp.class == String
      page_should_contain_text(text_or_regexp)
    elsif text_or_regexp.class == Regexp
      page_should_contain_regexp(text_or_regexp)
    else
      raise "Expected String or Regexp, got #{text_or_regexp.class}"
    end
  end

  ## Ensure that the current page content does not include a String or Regexp.
  def page_should_not_contain(text_or_regexp)
    if text_or_regexp.class == String
      page_should_not_contain_text(text_or_regexp)
    elsif text_or_regexp.class == Regexp
      page_should_not_contain_regexp(text_or_regexp)
    else
      raise "Expected String or Regexp, got #{text_or_regexp.class}"
    end
  end
end
