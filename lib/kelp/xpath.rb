module XPath
  # Return an XPath for any table row containing all strings in +texts+.
  def xpath_row_containing(texts)
    texts = [texts] if texts.class == String
    conditions = texts.collect do |text|
      "contains(., '#{text}')"
    end.join(' and ')
    return "//table//tr[#{conditions}]"
  end
end

