Feature: Field failure test

  Background:
    Given I visit "/form"


  Scenario: Field should be empty (FAIL)
    When I fill in "First name" with "Ivan"
    Then the "First name" field should be empty


  Scenario: Field should be empty within a scope (FAIL)
    When I fill in "Last name" with "Karamazov"
    Then the "Last name" field within "#person_form" should be empty


  Scenario: Field should contain (FAIL)
    When I fill in "First name" with "Dmitry"
    Then the "First name" field should contain "Alexy"


