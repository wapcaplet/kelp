Feature: Visibility

  Background:
    Given I visit "/home"

  Scenario: Should or shouldn't see
    Then I should see the following:
      | Homepage |
      | Hello world |
      | Goodbye world |

    And I should see the following:
      """
      First
      Second
      Third
      About Us
      """

    And I should not see the following:
      | Goodbye cruel world |


  Scenario: Should or shouldn't see in same row
    Then I should see a table row containing:
      | Eric | Edit |

    And I should see table rows containing:
      | John            | 666-5555 | Edit |
      | Graham "Quoted" | 555-4444 | Edit |

    And I should not see a table row containing:
      | Eric | Delete |

    And I should not see table rows containing:
      | John  | Delete |
      | Terry | Delete |


  Scenario: Should or shouldn't see next to
    Then I should see "Edit" next to "John"
    And I should not see "Delete" next to "John"


