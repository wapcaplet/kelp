Feature: Kelp Step Definitions

  As a Kelp developer
  I want to be sure the step definitions Kelp provides work correctly

  Background:
    Given the latest Kelp step definitions

  Scenario: Checkbox test
    When I run cucumber on "checkbox.feature"
    Then the results should include:
      """
      2 scenarios (2 passed)
      6 steps (6 passed)
      """

  Scenario: Dropdown test
    When I run cucumber on "dropdown.feature"
    Then the results should include:
      """
      3 scenarios (3 passed)
      11 steps (11 passed)
      """

  Scenario: Field test
    When I run cucumber on "field.feature"
    Then the results should include:
      """
      7 scenarios (7 passed)
      30 steps (30 passed)
      """

  Scenario: Visibility test
    When I run cucumber on "visibility.feature"
    Then the results should include:
      """
      10 scenarios (10 passed)
      46 steps (46 passed)
      """

  Scenario: Visibility failure test
    When I run cucumber on "visibility_fail.feature"
    Then the results should include:
      """
      Expected to see: ["First", "Missing", "Second", "Uh-oh", "Third", "Not there"]
      Did not see: ["Missing", "Uh-oh", "Not there"] (Kelp::Unexpected)
      """
    And the results should include:
      """
      Expected not to see: ["First", "Missing", "Second", "Uh-oh", "Third", "Not there"]
      Did see: ["First", "Second", "Third"] (Kelp::Unexpected)
      """


