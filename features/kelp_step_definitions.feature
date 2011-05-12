Feature: Kelp Step Definitions

  As a Kelp developer
  I want to be sure the step definitions Kelp provides work correctly

  Background:
    Given the latest Kelp step definitions

  Scenario: Checkbox test
    When I run cucumber on "checkbox.feature"
    Then the results should include:
      """
      4 scenarios (4 passed)
      12 steps (12 passed)
      """

  Scenario: Checkbox failure test
    When I run cucumber on "checkbox_fail.feature"
    Then the results should include:
      """
      Scenario: Checkbox should be checked (FAIL)
        Expected 'Like' to be checked, but it is unchecked. (Kelp::Unexpected)

      Scenario: Checkbox should not be checked (FAIL)
        Expected 'Like' to be unchecked, but it is checked. (Kelp::Unexpected)

      2 scenarios (2 failed)
      4 steps (2 failed, 2 passed)
      """

  Scenario: Dropdown test
    When I run cucumber on "dropdown.feature"
    Then the results should include:
      """
      4 scenarios (4 passed)
      14 steps (14 passed)
      """

  Scenario: Dropdown failure test
    When I run cucumber on "dropdown_fail.feature"
    Then the results should include:
      """
      Scenario: Dropdown should equal (FAIL)
        Expected 'Height' dropdown to equal 'Tall'
        Got 'Average' instead (Kelp::Unexpected)

      Scenario: Dropdown should include single value (FAIL)
        Expected 'Height' dropdown to include: ["Midget"]
        Missing: ["Midget"] (Kelp::Unexpected)

      Scenario: Dropdown should include multiple values (FAIL)
        Expected 'Height' dropdown to include: ["Tiny", "Average", "Tall", "Enormous"]
        Missing: ["Tiny", "Enormous"] (Kelp::Unexpected)

      Scenario: Dropdown should not include single value (FAIL)
        Expected 'Height' dropdown to not include: ["Average"]
        Did include: ["Average"] (Kelp::Unexpected)

      Scenario: Dropdown should not include multiple values (FAIL)
        Expected 'Height' dropdown to not include: ["Tiny", "Average", "Tall", "Enormous"]
        Did include: ["Average", "Tall"] (Kelp::Unexpected)

      5 scenarios (5 failed)
      10 steps (5 failed, 5 passed)
      """

  Scenario: Field test
    When I run cucumber on "field.feature"
    Then the results should include:
      """
      9 scenarios (9 passed)
      36 steps (36 passed)
      """

  Scenario: Field failure test
    When I run cucumber on "field_fail.feature"
    Then the results should include:
      """
      Scenario: Field should be empty (FAIL)
        Expected field 'First name' to be empty, but value is 'Ivan' (Kelp::Unexpected)

      Scenario: Field should be empty within a scope (FAIL)
        Expected field 'Last name' to be empty, but value is 'Karamazov' (Kelp::Unexpected)

      Scenario: Field should contain (FAIL)
        Expected 'First name' to contain 'Alexy'
        Got 'Dmitry' (Kelp::Unexpected)

      Scenario: Fill in a single field (FAIL)
        No field with id, name, or label 'Middle name' found (Kelp::FieldNotFound)

      Scenario: Fill in multiple fields (FAIL)
        Field 'Height' has no option 'Diminutive' (Kelp::OptionNotFound)

      5 scenarios (5 failed)
      13 steps (5 failed, 8 passed)
      """

  Scenario: Visibility test
    When I run cucumber on "visibility.feature"
    Then the results should include:
      """
      10 scenarios (10 passed)
      46 steps (46 passed)
      """

  Scenario: Visibility failure test
    When I run cucumber on "visibility_fail.feature"
    Then the results should include:
      """
      Scenario: Should see text (FAIL)
        Expected to see: ["First", "Missing", "Second", "Uh-oh", "Third", "Not there"]
        Did not see: ["Missing", "Uh-oh", "Not there"] (Kelp::Unexpected)

      Scenario: Should not see text (FAIL)
        Expected not to see: ["First", "Missing", "Second", "Uh-oh", "Third", "Not there"]
        Did see: ["First", "Second", "Third"] (Kelp::Unexpected)

      Scenario: Should see text within a scope (FAIL)
        Expected to see: ["Goodbye world"]
        Did not see: ["Goodbye world"] (Kelp::Unexpected)

      Scenario: Should not see text within a scope (FAIL)
        Expected not to see: ["Hello world"]
        Did see: ["Hello world"] (Kelp::Unexpected)

      Scenario: Should see regexp (FAIL)
        Expected to see: [/(Waffle|Pancake) world/]
        Did not see: [/(Waffle|Pancake) world/] (Kelp::Unexpected)

      Scenario: Should not see regexp (FAIL)
        Expected not to see: [/(Hello|Goodbye) world/]
        Did see: [/(Hello|Goodbye) world/] (Kelp::Unexpected)

      Scenario: Should see text in table rows (FAIL)
        | Eric | Delete |
        Expected, but did not see: ["Eric", "Delete"] in the same row (Kelp::Unexpected)

      Scenario: Should not see text in table rows (FAIL)
        | Eric | Edit |
        Did not expect, but did see: ["Eric", "Edit"] in the same row (Kelp::Unexpected)

      8 scenarios (8 failed)
      16 steps (8 failed, 8 passed)
      """

  Scenario: Navigation test
    When I run cucumber on "navigation.feature"
    Then the results should include:
      """
      6 scenarios (6 passed)
      20 steps (20 passed)
      """

  Scenario: Navigation failure test
    When I run cucumber on "navigation_fail.feature"
    Then the results should include:
      """
      Scenario: Should be on page (FAIL)
        Expected to be on page: 'home'
        Actually on page: '/form' (Kelp::Unexpected)

      Scenario: Follow a link (FAIL)
        No link with title, id or text 'Bogus link' found (Kelp::MissingLink)

      Scenario: Follow a bad link next to existing text (FAIL)
        No link with title, id or text '555' found in the same row as 'Eric' (Kelp::MissingLink)

      Scenario: Follow a link next to nonexistent text (FAIL)
        No table row found containing 'Edit' and 'Ramses' (Kelp::MissingRow)

      Scenario: Press a button (FAIL)
        No button with value, id or text 'Big red button' found (Kelp::MissingButton)

      5 scenarios (5 failed)
      11 steps (5 failed, 6 passed)
      """

