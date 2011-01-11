Kelp History
============

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

