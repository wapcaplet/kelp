require 'kelp/scoping'
require 'kelp/xpath'

module Kelp
  module Visibility
    include Scoping
    include XPath

    # Verify the presence of content on the page. Passes when all the given items
    # are found on the page, and fails if any of them are not found.
    #
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


    # Ensure that the current page content includes a String or Regexp.
    #
    # @param [String, Regexp] text_or_regexp
    #   Content you expect to be on the page
    #
    def page_should_contain(text_or_regexp)
      if text_or_regexp.class == String
        page_should_contain_text(text_or_regexp)
      elsif text_or_regexp.class == Regexp
        page_should_contain_regexp(text_or_regexp)
      else
        raise ArgumentError, "Expected String or Regexp, got #{text_or_regexp.class}"
      end
    end


    # Ensure that the current page content does not include a String or Regexp.
    #
    # @param [String, Regexp] text_or_regexp
    #   Content you expect to be missing from the page
    #
    def page_should_not_contain(text_or_regexp)
      if text_or_regexp.class == String
        page_should_not_contain_text(text_or_regexp)
      elsif text_or_regexp.class == Regexp
        page_should_not_contain_regexp(text_or_regexp)
      else
        raise ArgumentError, "Expected String or Regexp, got #{text_or_regexp.class}"
      end
    end


    # Verify that all items appear in the same table row. Passes if a +tr+
    # element exists containing all the given +texts+, and fails if no such
    # +tr+ exists. The texts may be in any order in the row.
    #
    #   should_see_in_same_row ["Yakko", "Rob Paulsen"]
    #   should_see_in_same_row ["Wakko", "Jess Harnell"]
    #   should_see_in_same_row ["Dot", "Tress MacNeille"]
    #
    # @param [Array] texts
    #   Array of Strings that should appear in the same row
    #
    def should_see_in_same_row(texts)
      page.should have_xpath(xpath_row_containing(texts))
    end


    # Verify that all items do not appear in the same table row. Passes if there
    # is no +tr+ containing all the given +texts+, and fails if there exists
    # such a +tr+.
    #
    #   should_not_see_in_same_row ["Pinky", "Maurice LaMarche"]
    #   should_not_see_in_same_row ["Brain", "Rob Paulsen"]
    #
    # @param [Array] texts
    #   Array of Strings that should not appear in the same row
    #
    def should_not_see_in_same_row(texts)
      page.should have_no_xpath(xpath_row_containing(texts))
    end


    def page_should_contain_text(text)
      if page.respond_to? :should
        page.should have_content(text)
      else
        assert page.has_content?(text)
      end
    end


    def page_should_contain_regexp(regexp)
      if page.respond_to? :should
        page.should have_xpath('.//*', :text => regexp)
      else
        assert page.has_xpath?('.//*', :text => regexp)
      end
    end


    def page_should_not_contain_text(text)
      if page.respond_to? :should
        page.should have_no_content(text)
      else
        assert page.has_no_content?(text)
      end
    end


    def page_should_not_contain_regexp(regexp)
      if page.respond_to? :should
        page.should have_no_xpath('.//*', :text => regexp)
      else
        assert page.has_no_xpath?('.//*', :text => regexp)
      end
    end
  end
end
