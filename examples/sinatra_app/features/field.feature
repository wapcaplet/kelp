Feature: Fields

  Background:
    Given I visit "/form"

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
