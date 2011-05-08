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
    And the results should include:
      """
      Then I should see "Goodbye world" within "#greeting"
        Expected to see: ["Goodbye world"]
        Did not see: ["Goodbye world"] (Kelp::Unexpected)
      """
    And the results should include:
      """
      Then I should not see "Hello world" within "#greeting"
        Expected not to see: ["Hello world"]
        Did see: ["Hello world"] (Kelp::Unexpected)
      """
    And the results should include:
      """
      Then I should see /(Waffle|Pancake) world/
        Expected to see: [/(Waffle|Pancake) world/]
        Did not see: [/(Waffle|Pancake) world/] (Kelp::Unexpected)
      """
    And the results should include:
      """
      Then I should not see /(Hello|Goodbye) world/
        Expected not to see: [/(Hello|Goodbye) world/]
        Did see: [/(Hello|Goodbye) world/]
      """
    And the results should include:
      """
      Then I should see a table row containing:
        | Eric | Delete |
        Expected, but did not see: ["Eric", "Delete"] in the same row (Kelp::Unexpected)
      """
    And the results should include:
      """
      Then I should not see a table row containing:
        | Eric | Edit |
        Did not expect, but did see: ["Eric", "Edit"] in the same row (Kelp::Unexpected)
      """
