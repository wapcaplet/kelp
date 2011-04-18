Feature: Kelp Step Definitions

  As a Kelp developer
  I want to be sure the step definitions Kelp provides work correctly

  Background:
    Given the latest Kelp step definitions

  Scenario: Dropdown test
    When I run cucumber on "dropdown.feature"
    Then the results should be:
      """
      3 scenarios (3 passed)
      10 steps (10 passed)
      """

  Scenario: Visibility test
    When I run cucumber on "visibility.feature"
    Then the results should be:
      """
      3 scenarios (3 passed)
      11 steps (11 passed)
      """

  Scenario: Checkbox test
    When I run cucumber on "checkbox.feature"
    Then the results should be:
      """
      2 scenarios (2 passed)
      6 steps (6 passed)
      """

