module Kelp
  # This module defines helper methods for restricting the scope of actions or
  # verifications on a webpage.
  #
  module Scoping
    # Execute a block of code within a given scope. If `locator` begins with
    # `/` or `./`, then it's assumed to be an XPath selector; otherwise, it's
    # assumed to be a CSS selector.
    def scope_within(locator)
      if locator
        # Use the selector_for method if it's defined
        if defined? selector_for
          within(*selector_for(locator)) { yield }
        # Otherwise, remove any surrounding double-quotes
        # and fall back on the Capybara locator syntax (CSS or XPath)
        else
          locator.gsub!(/^"(.*?)"$/, '\1')
          if locator =~ /\.?\//
            within(:xpath, locator) { yield }
          else
            within(:css, locator) { yield }
          end
        end
      else
        yield
      end
    end


    # Execute a block of code inside a given scope. `scope` must be a `Hash`
    # of parameters that describes the context in which to execute the block.
    #
    # @example
    #    in_scope :within => '#footer'
    #        click_link "Contact Us"
    #    end
    #
    # @param [Hash] scope
    #   Context in which to execute the block
    # @option scope [String] :within
    #   Selector string
    #
    def in_scope(scope)
      scope_within(scope[:within]) do
        yield
      end
    end
  end
end
