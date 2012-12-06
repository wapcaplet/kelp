require 'kelp/exceptions'

module Kelp
  module Helper
    # Convert a Cucumber::Ast::Table or multiline string into
    # a list of strings
    def listify(items)
      if items.class == Cucumber::Ast::Table
        strings = items.raw.flatten
      elsif items.class == Cucumber::Ast::DocString
        strings = items.to_s.split(/[\r\n]+/)
      else
        strings = items.split(/[\r\n]+/)
      end
    end


    # A slightly friendlier version of Capybara's `find_field`, which actually
    # tells you which locator failed to match (instead of giving a useless
    # Unable to find '#<XPath::Union:0xXXXXXXX>' message).
    #
    # @raise [Kelp::AmbiguousField]
    #   If more than one field with the given locator was found
    # @raise [Kelp::FieldNotFound]
    #   If no field with the given locator could be found
    #
    def nice_find_field(locator)
      begin
        field = find_field(locator)
      rescue Capybara::ElementNotFound
        raise Kelp::FieldNotFound,
          "Could not find field: '#{locator}'"
      end
    end


    # Return the appropriate "ExpectationNotMetError" class for the current
    # version of RSpec
    def rspec_unexpected
      if defined?(RSpec)
        RSpec::Expectations::ExpectationNotMetError
      else
        Spec::Expectations::ExpectationNotMetError
      end
    end

  end
end
