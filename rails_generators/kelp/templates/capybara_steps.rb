
require 'uri'
require 'cgi'
require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "paths"))
#require File.expand_path(File.join(File.dirname(__FILE__), "..", "support", "selectors"))

# Single-line step scoper
When /^(.*) within ([^:]+)$/ do |step, parent|
  scope_within(parent) { When step }
end

# Multi-line step scoper
When /^(.*) within ([^:]+):$/ do |step, parent, table_or_string|
  scope_within(parent) { When "#{step}:", table_or_string }
end


