require 'xpath'
require 'kelp/scoping'
require 'kelp/xpath'
require 'kelp/exceptions'
require 'kelp/helper'

module Kelp
  # This module defines methods for verifying the visibility (or invisibility)
  # of elements on a web page.
  #
  module Visibility
    include Scoping
    include XPaths

    # Verify the presence of content on the page. Passes when all the given items
    # are found on the page, and fails if any of them are not found.
    #
    # @example
    #   should_see "Animaniacs"
    #   should_see ["Yakko", "Wakko", "Dot"]
    #   should_see "Baloney", :within => "#slacks"
    #   should_see /(Animaney|Totally Insaney|Pinky and the Brainy)/
    #
    # @param [String, Regexp, Array] texts
    #   Text(s) or regexp(s) to look for
    # @param [Hash] scope
    #   Scoping keywords as understood by {#in_scope}
    #
    # @raise [Kelp::Unexpected]
    #   If any of the expected text strings are not seen in the given scope
    #
    def should_see(texts, scope={})
      in_scope(scope) do
        texts = [texts] if (texts.class == String || texts.class == Regexp)
        # Select all expected values that don't appear on the page
        unexpected = texts.select do |text|
          !page_contains?(text)
        end
        if !unexpected.empty?
          raise Kelp::Unexpected,
            "Expected to see: #{texts.inspect}\nDid not see: #{unexpected.inspect}"
        end
      end
    end


    # Verify the absence of content on the page. Passes when none of the given
    # items are found on the page, and fails if any of them are found.
    #
    # @param [String, Regexp, Array] texts
    #   Text(s) or Regexp(s) to look for
    # @param [Hash] scope
    #   Scoping keywords as understood by {#in_scope}
    #
    # @raise [Kelp::Unexpected]
    #   If any of the expected text strings are seen in the given scope
    #
    def should_not_see(texts, scope={})
      in_scope(scope) do
        texts = [texts] if (texts.class == String || texts.class == Regexp)
        # Select all unexpected values that do appear on the page
        unexpected = texts.select do |text|
          page_contains?(text)
        end
        if !unexpected.empty?
          raise Kelp::Unexpected,
            "Expected not to see: #{texts.inspect}\nDid see: #{unexpected.inspect}"
        end
      end
    end


    # Return `true` if the current page contains the given text or regular expression,
    # or `false` if it does not.
    #
    # @param [String, Regexp] text_or_regexp
    #   Text or regular expression to look for
    #
    # @raise [ArgumentError]
    #   If the given argument isn't a String or Regexp
    #
    def page_contains?(text_or_regexp)
      if text_or_regexp.class == String
        page.has_content?(text_or_regexp)
      elsif text_or_regexp.class == Regexp
        page.has_xpath?('.//*', :text => text_or_regexp)
      else
        raise ArgumentError, "Expected String or Regexp, got #{text_or_regexp.class}"
      end
    end


    # Verify that all items appear in the same table row. Passes if a `tr`
    # element exists containing all the given `texts`, and fails if no such
    # `tr` exists. The texts may be in any order in the row.
    #
    # @example
    #   should_see_in_same_row ["Yakko", "Rob Paulsen"]
    #   should_see_in_same_row ["Wakko", "Jess Harnell"]
    #   should_see_in_same_row ["Dot", "Tress MacNeille"]
    #
    # @param [Array] texts
    #   Array of Strings that should appear in the same row
    # @param [Hash] scope
    #   Scoping keywords as understood by {#in_scope}
    #
    def should_see_in_same_row(texts, scope={})
      in_scope(scope) do
        begin
          page.should have_xpath(xpath_row_containing(texts))
        rescue rspec_unexpected
          raise Kelp::Unexpected, "Expected, but did not see: #{texts.inspect} in the same row"
        end
      end
    end


    # Verify that all items do not appear in the same table row. Passes if there
    # is no `tr` containing all the given `texts`, and fails if there exists
    # such a `tr`.
    #
    # @example
    #   should_not_see_in_same_row ["Pinky", "Maurice LaMarche"]
    #   should_not_see_in_same_row ["Brain", "Rob Paulsen"]
    #
    # @param [Array] texts
    #   Array of Strings that should not appear in the same row
    # @param [Hash] scope
    #   Scoping keywords as understood by {#in_scope}
    #
    def should_not_see_in_same_row(texts, scope={})
      in_scope(scope) do
        begin
          page.should have_no_xpath(xpath_row_containing(texts))
        rescue rspec_unexpected
          raise Kelp::Unexpected, "Did not expect, but did see: #{texts.inspect} in the same row"
        end
      end
    end


    # Verify that a button with the given text appears on the page.
    # Works for `<input...>` as well as `<button...>` elements.
    #
    # @example
    #   should_see_button "Submit"
    #   should_see_button "Save changes", :within => "#preferences"
    #
    # @param [String] button_text
    #   Visible button text to look for
    # @param [Hash] scope
    #   Scoping keywords as understood by {#in_scope}
    #
    # @raise [Kelp::Unexpected]
    #   If no button with the given text exists in the given scope
    #
    # @since 0.1.9
    #
    def should_see_button(button_text, scope={})
      in_scope(scope) do
        xpath = XPath::HTML.button(button_text)
        if !page.has_xpath?(xpath)
          raise Kelp::Unexpected, "Expected to see button '#{button_text}', but button does not exist."
        end
      end
    end


    # Verify that a button with the given text does not appear on the page.
    # Works for `<input...>` as well as `<button...>` elements.
    #
    # @example
    #   should_not_see_button "Delete"
    #   should_not_see_button "Save changes", :within => "#read_only"
    #
    # @param [String] button_text
    #   Visible button text to look for
    # @param [Hash] scope
    #   Scoping keywords as understood by {#in_scope}
    #
    # @raise [Kelp::Unexpected]
    #   If a button with the given text does exist in the given scope
    #
    # @since 0.1.9
    #
    def should_not_see_button(button_text, scope={})
      in_scope(scope) do
        xpath = XPath::HTML.button(button_text)
        if page.has_xpath?(xpath)
          raise Kelp::Unexpected, "Did not expect to see button '#{button_text}', but button exists."
        end
      end
    end


    # -------------------------------------------------------------------
    # DEPRECATED METHODS
    # These will be removed in a future release of Kelp. Do not use them.
    # -------------------------------------------------------------------


    # Ensure that the current page content includes a String or Regexp.
    #
    # @deprecated
    #   Use should_see instead
    #
    # @param [String, Regexp] text_or_regexp
    #   Content you expect to be on the page
    #
    def page_should_contain(text_or_regexp)
      warn "WARNING: page_should_contain is deprecated. Use should_see instead."
      if !page_contains?(text_or_regexp)
        raise Kelp::Unexpected
      end
    end


    # Ensure that the current page content does not include a String or Regexp.
    #
    # @deprecated
    #   Use should_not_see instead
    #
    # @param [String, Regexp] text_or_regexp
    #   Content you expect to be missing from the page
    #
    def page_should_not_contain(text_or_regexp)
      warn "WARNING: page_should_not_contain is deprecated. Use should_not_see instead."
      if page_contains?(text_or_regexp)
        raise Kelp::Unexpected
      end
    end


    # Ensure that the current page content includes a String.
    #
    # @deprecated
    #   Use should_see instead
    #
    # @param [String] text
    #   Content you expect to be on the page
    #
    def page_should_contain_text(text)
      warn "WARNING: page_should_contain_text is deprecated. Use should_see instead."
      if !page.has_content?(text)
        raise rspec_unexpected
      end
    end


    # Ensure that the current page content matches a Regexp.
    #
    # @deprecated
    #   Use should_see instead
    #
    # @param [Regexp] regexp
    #   Content you expect to match
    #
    def page_should_contain_regexp(regexp)
      warn "WARNING: page_should_contain_regexp is deprecated. Use should_see instead."
      if !page.has_xpath?('.//*', :text => regexp)
        raise rspec_unexpected
      end
    end


    # Ensure that the current page content does not include a String.
    #
    # @deprecated
    #   Use should_not_see instead
    #
    # @param [String] text
    #   Content you expect to be missing from the page
    #
    def page_should_not_contain_text(text)
      warn "WARNING: page_should_not_contain_text is deprecated. Use should_not_see instead."
      if page.has_content?(text)
        raise rspec_unexpected
      end
    end


    # Ensure that the current page content does not match a Regexp.
    #
    # @deprecated
    #   Use should_not_see instead
    #
    # @param [Regexp] regexp
    #   Content you expect to fail matching
    #
    def page_should_not_contain_regexp(regexp)
      warn "WARNING: page_should_not_contain_regexp is deprecated. Use should_not_see instead."
      if page.has_xpath?('.//*', :text => regexp)
        raise rspec_unexpected
      end
    end

  end
end

