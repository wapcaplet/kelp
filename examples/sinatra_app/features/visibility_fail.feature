Feature: Visibility failures

  Background:
    Given I visit "/home"


  Scenario: Should see text (expect failure)
    Then I should see the following:
      """
      First
      Missing
      Second
      Uh-oh
      Third
      Not there
      """


  Scenario: Should not see text (expect failure)
    Then I should not see the following:
      """
      First
      Missing
      Second
      Uh-oh
      Third
      Not there
      """


  Scenario: Should see text within a scope (expect failure)
    Then I should see "Goodbye world" within "#greeting"


  Scenario: Should not see text within a scope (expect failure)
    Then I should not see "Hello world" within "#greeting"


  Scenario: Should see regexp (expect failure)
    Then I should see /(Waffle|Pancake) world/


  Scenario: Should not see regexp (expect failure)
    Then I should not see /(Hello|Goodbye) world/


  Scenario: Should see text in table rows (expect failure)
    Then I should see a table row containing:
      | Eric | Delete |


  Scenario: Should not see text in table rows (expect failure)
    Then I should not see a table row containing:
      | Eric | Edit |

