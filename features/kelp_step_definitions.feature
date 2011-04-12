Feature: Kelp Step Definitions

  As a Kelp developer
  I want to be sure the step definitions Kelp provides work correctly

  Scenario: Regression test
    Given a sinatra application with the latest Kelp step definitions
    When I run "cucumber features -q --no-color" in the sinatra app
    Then the results should be:
      """
      5 scenarios (5 passed)
      18 steps (18 passed)
      """

