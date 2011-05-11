Feature: Navigation

  Background:
    Given I am on "/home"


  Scenario: Go to page, should be on page
    When I go to "/form"
    Then I should be on "/form"


  Scenario: Follow a link
    When I follow "About Us"
    Then I should be on "/about"


  Scenario: Follow a link within a scope
    When I follow "About Us" within "#links"
    Then I should be on "/about"


  Scenario: Follow a link next to something else
    When I follow "Edit" next to "Eric"
    Then I should be on "/edit1"


  Scenario: Press a button
    When I go to "/form"
    And I press "Submit person form"
    Then I should be on "/thanks"


  Scenario: Press a button within a scope
    When I am on "/form"
    And I press "Save preferences" within "#preferences_form"
    Then I should be on "/thanks"


