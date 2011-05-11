Feature: Fields

  Background:
    Given I am on "/form"


  Scenario: Field should be empty
    Then the "First name" field should be empty
    And the "First name" field within "#person_form" should be empty
    And the "Last name" field should be empty
    And the "Last name" field within "#person_form" should be empty


  Scenario: Fields should contain
    Then the fields should contain:
      | First name |                        |
      | Last name  |                        |
      | Weight     | Light                  |
      | Height     | Average                |
      | Message    | Your message goes here |


  Scenario: Fill in single fields by label
    When I fill in "First name" with "Adam"
    And I fill in "Savage" for "Last name"
    Then the "First name" field should contain "Adam"
    And the "Last name" field should contain "Savage"


  Scenario: Fill in single fields by id
    When I fill in "first_name" with "Jamie"
    And I fill in "Hyneman" for "last_name"
    Then the "first_name" field should contain "Jamie"
    And the "last_name" field should contain "Hyneman"


  Scenario: Fill in single fields within a scope
    When I fill in "First name" with "Homer" within "#person_form"
    And I fill in "First name" with "Marge" within "#spouse_form"
    Then the "First name" field within "#person_form" should contain "Homer"
    And the "First name" field within "#spouse_form" should contain "Marge"


  Scenario: Fill in multiple fields by label
    When I fill in the following:
      | First name | Andre                  |
      | Last name  | Roussimoff             |
      | Weight     | Heavy                  |
      | Height     | Tall                   |
      | Message    | Anybody want a peanut? |

    Then the fields should contain:
      | First name | Andre                  |
      | Last name  | Roussimoff             |
      | Weight     | Heavy                  |
      | Height     | Tall                   |
      | Message    | Anybody want a peanut? |


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


