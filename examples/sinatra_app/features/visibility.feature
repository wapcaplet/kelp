Feature: Visibility

  Background:
    Given I visit "/home"

  Scenario: Should see
    Then I should see the following:
      | Hello world |
      | Goodbye world |

