require 'kelp/helper'
require 'kelp/scoping'
require 'kelp/exceptions'

module Kelp
  module Checkbox
    include Scoping
    include Helper

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
