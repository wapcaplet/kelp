Feature: Visibility

  Background:
    Given I am on "/home"


  Scenario: Should or shouldn't see text
    Then I should see the following:
      | Homepage      |
      | Hello world   |
      | Goodbye world |

    And I should see the following:
      """
      First
      Second
      Third
      About Us
      """

    But I should not see the following:
      | Goodbye cruel world |

    And I should not see the following:
      """
      Fourth
      Firth of Fifth
      About someone else
      """


  Scenario: Should or shouldn't see text within a scope
    Then I should see "Hello world" within "#greeting"
    And I should see the following within "#table_a":
      | Eric  |
      | John  |
      | Terry |

    But I should not see "Goodbye world" within "#greeting"
    And I should not see the following within "#table_a":
      | Graham  |
      | Michael |


  Scenario: Should or shouldn't see regexp
    Then I should see /(Hello|Goodbye) world/
    But I should not see /(Spam|Eggs) world/


  Scenario: Should or shouldn't see regexp within a scope
    Then I should see /\d+-\d+/ within "#table_a"
    But I should not see /\d\d\d\d\d/ within "#table_a"


  Scenario: Should or shouldn't see text in table rows
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


  Scenario: Should or shouldn't see text in table rows within a scope
    Then I should see table rows within "#table_a" containing:
      | Eric  | Edit |
      | John  | Edit |
      | Terry | Edit |
    But I should not see table rows within "#table_a" containing:
      | Eric  | Delete |
      | John  | Delete |
      | Terry | Delete |


  Scenario: Should or shouldn't see next to
    Then I should see "Edit" next to "John"
    But I should not see "Delete" next to "John"

    And I should see the following next to "Eric":
      | 555-4444 | Edit |
    And I should see the following next to "John":
      """
      666-5555
      Edit
      """

    But I should not see the following next to "Eric":
      | 666-5555 | Delete |
    And I should not see the following next to "John":
      """
      555-4444
      Copy
      """


  Scenario: Should or shouldn't see next to within a scope
    Then I should see "Edit" next to "Eric" within "#table_a"
    But I should not see "Edit" next to "Eric" within "#table_b"

    And I should see the following next to "Terry" within "#table_a":
      | 777-6666 | Edit |
    And I should see the following next to "Terry" within "#table_b":
      """
      Big
      thing
      """

    But I should not see the following next to "Terry" within "#table_a":
      | Big | thing |
    And I should not see the following next to "Terry" within "#table_b":
      """
      Crunchy
      frog
      """


  Scenario: Should or shouldn't see button
    When I go to "/form"
    Then I should see a "Submit person form" button
    But I should not see a "Submit animal form" button


  Scenario: Should or shouldn't see button within a scope
    When I go to "/form"
    Then I should see a "Submit person form" button within "#person_form"
    But I should not see a "Submit person form" button within "#preferences_form"

