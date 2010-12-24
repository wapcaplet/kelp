module Kelp
  module Attribute
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

  end

end
