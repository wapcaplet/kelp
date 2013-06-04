Kelp History
============

0.2.4
-----

- Switch to Capybara 2
- Support for ambiguous fields
- Several fixes for Ruby 1.9 contributed by @eostrom


0.2.3
-----

- Rails 3 generator tested and working


0.2.2
-----

- Added Rails 3 generator


0.2.1
-----

- Fixed arity mismatch bug in "I am on / I go to" step definition
- Allow "an" in "should see ... button" step definitions
- Allow empty strings in some stepdefs


0.2.0
-----

- Fixed a 'within' clause quoted identifier glitch in cucumber output
- Fixed bug in "fill in the following" step definition
- Raise Kelp::Unexpected instead of RSpec exception
- Dropdown inclusion steps now accumulate unexpected values instead of failing on the first one
- More cucumber self-tests to prevent breakages


0.1.9
-----

- Fill-in methods now accept checkbox and dropdown fields
- Generated step definitions now replace those of cucumber-rails (web_steps.rb)
- should_be_on_page and should_have_query methods added
- should_see_button and should_not_see_button visibility methods added


0.1.8
-----

- Fixed bug with should_see / should_not_see in RSpec 1.x


0.1.7
-----

- Fixed bug with dropdown_should_include, caused by Rails string monkeypatching
- Allow should_see and should_not_see to check all strings before failing


0.1.6
-----

- Improved generated step definitions in kelp_steps.rb, fixed some bugs therein
- Expanded cucumber self-tests for generated step definitions
- Fixed bug with field_should_be_empty; now works with textarea


0.1.5
-----

- Added Rails generator for generating kelp_steps.rb with some predefined steps
- Included some cucumber self-tests, especially to test the generated steps
- Fixed scoping error in xpath_row_containing


0.1.4
-----

- Fixed single-quote escaping issue in table rows and dropdowns
- Began adding Webrat support (still untested and not fully implemented)


0.1.3
-----

- Messed up 0.1.4 release. Incorrectly requires webrat.


0.1.2
-----

- Improved namespacing for submodules, so you can be more specific about
  requiring the helpers you need.
- Improved documentation and formatting, and converted all docs to YARD format.
- Added new methods fill_in_field, added scoping to field_should(_not)_contain
- Modified scope_within to use cucumber-rails' selector_for if it's defined


0.1.1
-----

Initial public release. Includes basic helpers for checking element visibility
(should_see, should_not_see etc.) as well as navigation (press, follow,
click_link_in_row), form filling and verification (fill_in_fields,
fields_should_contain, dropdown_should_equal, etc.), with many of these
methods supporting a :within scope.

