Feature: Visibility failures

  Background:
    Given I visit "/home"

  Scenario: Should see - failure
    Then I should see the following:
      """
      First
      Missing
      Second
      Uh-oh
      Third
      Not there
      """

  Scenario: Should not see - failure
    Then I should not see the following:
      """
      First
      Missing
      Second
      Uh-oh
      Third
      Not there
      """

