require 'kelp/helper'
require 'kelp/scoping'
require 'kelp/exceptions'

module Kelp
  module Checkbox
    include Scoping
    include Helper

    # Verify that the given checkbox is checked.
    #
    # @param [String] checkbox
    #   Capybara locator for the checkbox
    # @param [Hash] scope
    #   Scoping keywords as understood by {#in_scope}
    #
    # @raise [Kelp::Unexpected]
    #   If the given checkbox is not checked
    #
    # @since 0.1.2
    #
    def checkbox_should_be_checked(checkbox, scope={})
      in_scope(scope) do
        field_checked = find_field(checkbox)['checked']
        puts field_checked.inspect
        if !field_checked
          raise Kelp::Unexpected,
            "Expected '#{checkbox}' to be checked, but it is unchecked."
        end
      end
    end


    # Verify that the given checkbox is not checked.
    #
    # @param [String] checkbox
    #   Capybara locator for the checkbox
    # @param [Hash] scope
    #   Scoping keywords as understood by {#in_scope}
    #
    # @raise [Kelp::Unexpected]
    #   If the given checkbox is checked
    #
    # @since 0.1.2
    #
    def checkbox_should_not_be_checked(checkbox, scope={})
      in_scope(scope) do
        field_checked = find_field(checkbox)['checked']
        if field_checked
          raise Kelp::Unexpected,
            "Expected '#{checkbox}' to be unchecked, but it is checked."
        end
      end
    end
  end
end
