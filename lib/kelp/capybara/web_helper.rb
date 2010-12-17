require 'kelp/helper'

module WebHelper
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

