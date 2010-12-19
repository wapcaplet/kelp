require 'kelp/helper'

module WebHelper
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

  # Verify that a table row does NOT exist containing all the given text strings.
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

  # Click a link in a table row containing the given text.
  #
  #   click_link_in_row "Edit", "Pinky"
  #
  # @param [String] link
  #   Content of the link to click
  # @param [String] text
  #   Other content that must be in the same row
  #
  def click_link_in_row(link, text)
    row = find(:xpath, xpath_row_containing([link, text]))
    row.click_link(link)
  end

  # Verify that the HTML element with the given ID exists, and is disabled (has
  # the +disabled+ attribute).
  #
  # @param [String] element_id
  #   HTML +id+ attribute of the element that should be disabled
  #
  def should_be_disabled(element_id)
    page.should have_xpath("//*[@id='#{element_id}']")
    page.should have_xpath("//*[@id='#{element_id}' and @disabled]")
  end

  # Verify that the HTML element with the given ID exists, and is enabled (does
  # not have the +disabled+ attribute).
  #
  # @param [String] element_id
  #   HTML +id+ attribute of the element that should be enabled
  #
  def should_be_enabled(element_id)
    page.should have_xpath("//*[@id='#{element_id}']")
    page.should have_no_xpath("//*[@id='#{element_id}' and @disabled]")
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

