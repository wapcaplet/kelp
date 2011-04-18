Feature: Checkboxes

  Background:
    Given I visit "/form"

  Scenario: Checkbox should be checked
    Then the "Like" checkbox next to "Apple" should be checked
    And the "Like" checkbox next to "Apple" should not be unchecked

  Scenario: Checkbox should not be checked
    Then the "Like" checkbox next to "Banana" should be unchecked
    And the "Like" checkbox next to "Banana" should not be checked
