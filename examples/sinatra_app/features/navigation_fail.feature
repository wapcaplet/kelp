Feature: Navigation failures

  Background:
    Given I am on "/home"


  Scenario: Should be on page (FAIL)
    When I go to "/form"
    Then I should be on "home"


  Scenario: Follow a link (FAIL)
    When I follow "Bogus link"


  Scenario: Follow a bad link next to existing text (FAIL)
    When I follow "555" next to "Eric"


  Scenario: Follow a link next to nonexistent text (FAIL)
    When I follow "Edit" next to "Ramses"


  Scenario: Press a button (FAIL)
    When I press "Big red button"

