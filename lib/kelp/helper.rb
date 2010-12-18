# This module includes helpers for basic webpage navigation and verification.

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

  # Execute a block of code inside a given scope. +scope+ must be a +Hash+
  # of parameters that describes the context in which to execute the block.
  #
  # Examples:
  #
  #    in_scope :within => '#footer'
  #        click_link "Contact Us"
  #    end
  #
  def in_scope(scope)
    scope_within(scope[:within]) do
      yield
    end
  end

  # Verify the presence of content on the page. Passes when all the given items
  # are found on the page, and fails if any of them are not found.
  #
  # @param [String, Regexp, Array] texts
  #   Text(s) or regexp(s) to look for
  # @param [Hash] scope
  #   Scoping keywords as understood by {#in_scope}
  #
  # Examples:
  #
  #   should_see "Animaniacs"
  #   should_see ["Yakko", "Wakko", "Dot"]
  #   should_see "Baloney", :within => "#slacks"
  #   should_see /(Animaney|Totally Insaney|Pinky and the Brainy)/
  #
  def should_see(texts, scope={})
    texts = [texts] if (texts.class == String || texts.class == Regexp)
    in_scope(scope) do
      texts.each do |text|
        page_should_contain text
      end
    end
  end

  # Verify the absence of content on the page. Passes when none of the given
  # items are found on the page, and fails if any of them are found.
  #
  # @param [String, Regexp, Array] texts
  #   Text(s) or regexp(s) to look for
  # @param [Hash] scope
  #   Scoping keywords as understood by {#in_scope}
  #
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
  # Follow a link on the page.
  #
  # @param [String] link
  #   Capybara locator expression (id, name, or link text)
  # @param [Hash] scope
  #   Scoping keywords as understood by {#in_scope}
  #
  # Examples:
  #
  #   follow "Login"
  #   follow "Contact Us", :within => "#footer"
  #
  def follow(link, scope={})
    in_scope(scope) do
      click_link(link)
    end
  end

  # Press a button on the page.
  #
  # @param [String] button
  #   Capybara locator expression (id, name, or button text)
  # @param [Hash] scope
  #   Scoping keywords as understood by {#in_scope}
  #
  # Examples:
  #
  #   press "Cancel"
  #   press "Submit", :within => "#survey"
  #
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
