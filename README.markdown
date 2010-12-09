Kelp
====

This project aims to package a collection of useful helper methods for
Cucumber. Currently, the provided methods depend on Capybara, though support
may eventually be added for Webrat, email-spec, or related tools.


Installation
------------

Just copy files from `lib` into your `features/step_definitions` folder as you
need them.


Usage
-----

The provided helpers are designed to make it easier to do things you might
normally do with nested step definitions. For example, if you need to verify
the presence of several text strings on a webpage, you might normally do this
inside a Cucumber step definition:

    Then %{I should see "Welcome"}
      And %{I should see "Thanks for visiting"}
      And %{I should see "Login"}

Using the provided helper method `should_see`, you can do this instead:

    should_see "Welcome"
    should_see "Thanks for visiting"
    should_see "Login"

Or even this:

    should_see [
      "Welcome",
      "Thanks for visiting",
      "Login"
    ]

Other methods are similar to their counterparts in Capybara's generated step
definitions. Instead of this:

    When %{I follow "Login"}
      And %{I fill in "Username" with "skroob"}
      And %{I fill in "Password" with "12345"}
      And %{I press "Log me in"}

Try this:

    follow "Login"
    fill_in_fields {
        "Username" => "skroob",
        "Password" => "12345",
    }
    press "Log me in"

Many of the provided methods also accept keywords to define the scope of an
action. For instance, if you want to look within an element with
`id="greeting"`, you could do:

    should_see "Welcome", :within => "#greeting"

Or to press the "Ludicrous" button under the "Speed" heading:

    press "Ludicrous", :after => "Speed"

Check out the comments in the source code for more about what's possible.


Future plans
------------

* Support other stuff besides Caypbara
* Turn the project into a proper Rails plugin, with generators


Copyright
---------

Copyright (c) 2010 Eric Pierce
Released under the MIT license.
See LICENSE for details.

