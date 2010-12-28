require 'kelp/helper'
require 'kelp/scoping'

module Kelp
  module Checkbox
    include Scoping
    include Helper

    def checkbox_should_be_checked(checkbox, scope={})
      in_scope(scope) do
        field_checked = find_field(checkbox)['checked']
        if field_checked.respond_to? :should
          field_checked.should be_true
        else
          assert field_checked
        end
      end
    end

    def checkbox_should_not_be_checked(checkbox, scope={})
      in_scope(scope) do
        field_checked = find_field(checkbox)['checked']
        if field_checked.respond_to? :should
          field_checked.should be_false
        else
          assert !field_checked
        end
      end
    end
  end
end
