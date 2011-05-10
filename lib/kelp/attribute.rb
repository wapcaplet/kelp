module Kelp
  # This module defines helper methods for verifying attributes of HTML
  # elements on a web page.
  #
  module Attribute
    # Verify that the HTML element with the given ID exists, and is disabled (has
    # the `disabled` attribute).
    #
    # @param [String] element_id
    #   HTML `id` attribute of the element that should be disabled
    #
    # @raise [Kelp::Unexpected]
    #   If the given element id is not found, or the element is not disabled
    #
    def should_be_disabled(element_id)
      if page.has_xpath?("//*[@id='#{element_id}']")
        if !page.has_xpath?("//*[@id='#{element_id}' and @disabled]")
          raise Kelp::Unexpected,
            "Expected element with id='#{element_id}' to be disabled," + \
            " but the 'disabled' attribute is not present."
        end
      else
        raise Kelp::Unexpected,
          "Element with id='#{element_id}' not found."
      end
    end


    # Verify that the HTML element with the given ID exists, and is enabled (does
    # not have the `disabled` attribute).
    #
    # @param [String] element_id
    #   HTML `id` attribute of the element that should be enabled
    #
    # @raise [Kelp::Unexpected]
    #   If the given element id is not found, or the element is not enabled
    #
    def should_be_enabled(element_id)
      if page.has_xpath?("//*[@id='#{element_id}']")
        if page.has_xpath?("//*[@id='#{element_id}' and @disabled]")
          raise Kelp::Unexpected,
            "Expected element with id='#{element_id}' to be enabled," + \
            " but the 'disabled' attribute is present."
        end
      else
        raise Kelp::Unexpected,
          "Element with id='#{element_id}' not found."
      end
    end

  end

end
