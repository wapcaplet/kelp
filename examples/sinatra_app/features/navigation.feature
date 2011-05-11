Feature: Navigation

  Background:
    Given I am on "/home"


  Scenario: Go to page, should be on page
    When I am on "/form"
    Then I should be on "/form"

