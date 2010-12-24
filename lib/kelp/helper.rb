module Kelp
  module Helper
    # A slightly friendlier version of Capybara's +find_field+, which actually
    # tells you which locator failed to match (instead of giving a useless
    # Unable to find '#<XPath::Union:0xXXXXXXX>' message).
    def nice_find_field(locator)
      begin
        field = find_field(locator)
      rescue Capybara::ElementNotFound
        raise "Could not find field with locator: '#{locator}'"
      end
    end
  end
end
