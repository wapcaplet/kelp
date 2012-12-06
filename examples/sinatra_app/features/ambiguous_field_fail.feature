Feature: Ambiguous fields failure test

  Background:
    Given I am on "/form2"


  Scenario: Fill in single ambiguous field (FAIL)
    When I fill in "First name" with "Homer"
    Then the "First name" field should contain "Homer"

  Scenario: Fill in multiple ambiguous fields by label (FAIL)
    When I fill in the following:
      | Last name  | Griffin |
      | First name | Peter   |
    Then the fields should contain:
      | Last name  | Griffin |
      | First name | Peter   |
