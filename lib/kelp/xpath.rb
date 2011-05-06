module Kelp
  # This module defines helper methods for building XPath expressions.
  #
  module XPaths
    # Return an XPath for any table row containing all strings in `texts`,
    # within the current context.
    def xpath_row_containing(texts)
      texts = [texts] if texts.class == String
      conditions = texts.collect do |text|
        "contains(., #{xpath_sanitize(text)})"
      end.join(' and ')
      return ".//tr[#{conditions}]"
    end

    # Return the given text string in an XPath-safe form, with
    # any single-quotes escaped by using the XPath `concat`
    # function to combine them with the rest of the text.
    #
    # @example
    #   xpath_sanitize("Bob's")
    #   # => concat('Bob', "'", 's')
    #
    def xpath_sanitize(text)
      # If there's nothing to escape, just wrap text in single-quotes
      if !text.include?("'")
        return "'#{text}'"
      else
        result = text.gsub(/'/, %{', "'", '})
        return "concat('#{result}')"
      end
    end
  end
end
