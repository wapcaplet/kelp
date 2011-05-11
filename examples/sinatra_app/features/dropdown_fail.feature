Feature: Dropdown failures

  Background:
    Given I am on "/form"

  Scenario: Dropdown should equal (FAIL)
    Then the "Height" dropdown should equal "Tall"

  Scenario: Dropdown should include single value (FAIL)
    Then the "Height" dropdown should include "Midget"

  Scenario: Dropdown should include multiple values (FAIL)
    And the "Height" dropdown should include:
      | Tiny     |
      | Average  |
      | Tall     |
      | Enormous |

  Scenario: Dropdown should not include single value (FAIL)
    Then the "Height" dropdown should not include "Average"

  Scenario: Dropdown should not include multiple values (FAIL)
    And the "Height" dropdown should not include:
      | Tiny     |
      | Average  |
      | Tall     |
      | Enormous |

