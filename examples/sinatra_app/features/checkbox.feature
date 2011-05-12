Feature: Checkboxes

  Background:
    Given I am on "/form"

  Scenario: Checkbox should be checked
    Then the "Like" checkbox next to "Apple" should be checked
    And the "Like" checkbox next to "Apple" should not be unchecked

  Scenario: Checkbox should not be checked
    Then the "Like" checkbox next to "Banana" should be unchecked
    And the "Like" checkbox next to "Banana" should not be checked

  Scenario: Check a checkbox
    When I check "I like salami"
    Then the "I like salami" checkbox should be checked

  Scenario: Uncheck a checkbox
    When I uncheck "I like cheese"
    Then the "I like cheese" checkbox should be unchecked

