Feature: Fields

  Background:
    Given I am on "/form"


  Scenario: Field should be empty
    Then the "First name" field should be empty
    And the "First name" field should be empty
    And the "Last name" field should be empty
    And the "Last name" field should be empty


  Scenario: Fields should contain
    Then the fields should contain:
      | First name |                        |
      | Last name  |                        |
      | Weight     | Light                  |
      | Height     | Average                |
      | Message    | Your message goes here |


  Scenario: Field should contain
    Then the "First name" field should contain ""
    And the "Message" field should contain "Your message goes here"


  Scenario: Field should not contain
    When I fill in "First name" with "Adam"
    Then the "First name" field should not contain "Jamie"


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
