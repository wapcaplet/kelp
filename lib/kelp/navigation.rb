include 'kelp/scoping'
include 'kelp/xpath'

module Navigation
  include Scoping
  include XPath

  # Follow a link on the page.
  #
  #   follow "Login"
  #   follow "Contact Us", :within => "#footer"
  #
  # @param [String] link
  #   Capybara locator expression (id, name, or link text)
  # @param [Hash] scope
  #   Scoping keywords as understood by {#in_scope}
  #
  def follow(link, scope={})
    in_scope(scope) do
      click_link(link)
    end
  end

  # Press a button on the page.
  #
  #   press "Cancel"
  #   press "Submit", :within => "#survey"
  #
  # @param [String] button
  #   Capybara locator expression (id, name, or button text)
  # @param [Hash] scope
  #   Scoping keywords as understood by {#in_scope}
  #
  def press(button, scope={})
    in_scope(scope) do
      click_button(button)
    end
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

end

