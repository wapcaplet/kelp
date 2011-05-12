Feature: Dropdowns

  Background:
    Given I am on "/form"

  Scenario: Dropdown should equal
    Then the "Height" dropdown should equal "Average"

  Scenario: Dropdown should include
    Then the "Height" dropdown should include "Tall"
    And the "Quotes" dropdown should include "Single 'quotes'"
    And the "Height" dropdown should include:
      | Short   |
      | Average |
      | Tall    |
    And the "Quotes" dropdown should include:
      | Single 'quotes'              |
      | "Double" quotes              |
      | 'Single' and "Double" quotes |
    And the "Favorite Colors" dropdown should include:
      """
      Red
      Green
      Blue
      """

  Scenario: Dropdown should not include
    Then the "Height" dropdown should not include "Midget"
    And the "Height" dropdown should not include:
      | Dwarf |
      | Behemoth |

  Scenario: Select a value from a dropdown
    When I select "Tall" from "Height"
    Then the "Height" dropdown should equal "Tall"

