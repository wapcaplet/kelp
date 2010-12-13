Usage
=====

To use Kelp's helpers in your Cucumber step definitions, simply ``require`` the
helper module you're interested in:

.. code-block:: ruby

    require 'kelp/capybara/web_helper'

Then add the relevant modules to Cucumber's ``World``:

.. code-block:: ruby

    World(WebHelper)

Many of the provided helpers are designed to make it easier to do things you
might otherwise be tempted to do with nested step definitions. For example, if
you need to verify the presence of several text strings on a webpage, you might
have a step definition like this:

.. code-block:: ruby

    Then /^I should see the login page$/ do
      Then %{I should see "Welcome"}
      And %{I should see "Thanks for visiting"}
      And %{I should see "Login"}
    end

Using the provided helper method ``should_see``, you can do this instead:

.. code-block:: ruby

    Then /^I should see the login page$/ do
      should_see "Welcome"
      should_see "Thanks for visiting"
      should_see "Login"
    end

Or even this:

.. code-block:: ruby

    Then /^I should see the login page$/ do
      should_see [
        "Welcome",
        "Thanks for visiting",
        "Login"
      ]
    end

Many of the provided methods are similar to their counterparts in the
Cucumber-Rails generated step definitions. Following links, filling in fields,
and pressing buttons can all be easily done with Ruby code instead of nested
steps. Thus this:

.. code-block:: ruby

    When %{I follow "Login"}
    And %{I fill in "Username" with "skroob"}
    And %{I fill in "Password" with "12345"}
    And %{I press "Log me in"}

translates to this:

.. code-block:: ruby

    follow "Login"
    fill_in_fields \
      "Username" => "skroob",
      "Password" => "12345"
    press "Log me in"

Several methods also accept keywords to define the scope of an action. For
instance, if you want to look within an element with ``id="greeting"``, do:

.. code-block:: ruby

    should_see "Welcome", :within => "#greeting"

At the moment, the ``:within`` keyword is the only accepted scope; the locator
you pass to this should be in whatever format your ``Capybara.default_selector``
is set to. Other keywords like ``:before`` or ``:after`` may be supported in future
revisions.

