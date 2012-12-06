Feature: Ambiguous fields

  Background:
    Given I am on "/form2"


  Scenario: Fill in single fields within a scope
    When I fill in "First name" with "Homer" within "#person_form"
    And I fill in "First name" with "Marge" within "#spouse_form"
    Then the "First name" field within "#person_form" should contain "Homer"
    And the "First name" field within "#spouse_form" should contain "Marge"


  Scenario: Fill in multiple fields by label within a scope
    When I fill in the following within "#person_form":
      | First name | Peter   |
      | Last name  | Griffin |
    And I fill in the following within "#spouse_form":
      | First name | Lois    |
      | Last name  | Griffin |

    Then the fields within "#person_form" should contain:
      | First name | Peter   |
      | Last name  | Griffin |
    And the fields within "#spouse_form" should contain:
      | First name | Lois    |
      | Last name  | Griffin |



