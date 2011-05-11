Feature: Checkbox failures

  Background:
    Given I am on "/form"

  Scenario: Checkbox should be checked (FAIL)
    Then the "Like" checkbox next to "Banana" should be checked

  Scenario: Checkbox should not be checked (FAIL)
    Then the "Like" checkbox next to "Apple" should not be checked

