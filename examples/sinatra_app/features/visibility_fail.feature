Feature: Visibility failures

  Background:
    Given I am on "/home"


  Scenario: Should see text (FAIL)
    Then I should see the following:
      """
      First
      Missing
      Second
      Uh-oh
      Third
      Not there
      """


  Scenario: Should not see text (FAIL)
    Then I should not see the following:
      """
      First
      Missing
      Second
      Uh-oh
      Third
      Not there
      """


  Scenario: Should see text within a scope (FAIL)
    Then I should see "Goodbye world" within "#greeting"


  Scenario: Should not see text within a scope (FAIL)
    Then I should not see "Hello world" within "#greeting"


  Scenario: Should see regexp (FAIL)
    Then I should see /(Waffle|Pancake) world/


  Scenario: Should not see regexp (FAIL)
    Then I should not see /(Hello|Goodbye) world/


  Scenario: Should see text in table rows (FAIL)
    Then I should see a table row containing:
      | Eric | Delete |


  Scenario: Should not see text in table rows (FAIL)
    Then I should not see a table row containing:
      | Eric | Edit |

