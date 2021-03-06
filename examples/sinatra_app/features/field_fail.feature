Feature: Field failure test

  Background:
    Given I am on "/form"


  Scenario: Field should be empty (FAIL)
    When I fill in "First name" with "Ivan"
    Then the "First name" field should be empty


  Scenario: Field should be empty within a scope (FAIL)
    When I fill in "Last name" with "Karamazov"
    Then the "Last name" field within "#person_form" should be empty


  Scenario: Field should contain (FAIL)
    When I fill in "First name" with "Dmitry"
    Then the "First name" field should contain "Alexy"


  Scenario: Field should not contain (FAIL)
    When I fill in "First name" with "Ivan"
    Then the "First name" field should not contain "Ivan"


  Scenario: Fill in a single field (FAIL)
    When I fill in "Middle name" with "Fyodorovitch"


  Scenario: Fill in multiple fields (FAIL)
    When I fill in the following:
      | First name | Wallace    |
      | Last name  | Shawn      |
      | Height     | Diminutive |

