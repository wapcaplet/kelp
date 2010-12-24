module Kelp
  module Scoping
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
