Kelp
====

This project aims to package a collection of useful helper methods for
Cucumber. Currently, the provided methods depend on Capybara, though support
may eventually be added for Webrat, email-spec, or related tools.

The name "Kelp" is a contraction of "Cuke Helpers". It was chosen because it's
short, easy to remember, and is in keeping with the theme of greenish plants.


Installation
------------

Until Kelp grows a saner approach for installation (such as a Rails
generator), just copy files from `lib` into your `features/step_definitions`
folder as you need them, and add them to Cucumber's world, i.e.

    World(WebHelper)
    World(FormHelper)


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

Many of the provided methods are similar to their counterparts in the
Cucumber-Rails generated step definitions. Instead of this:

    When %{I follow "Login"}
      And %{I fill in "Username" with "skroob"}
      And %{I fill in "Password" with "12345"}
      And %{I press "Log me in"}

Try this:

    follow "Login"
    fill_in_fields \
      "Username" => "skroob",
      "Password" => "12345"
    press "Log me in"

Several methods also accept keywords to define the scope of an action. For
instance, if you want to look within an element with `id="greeting"`, do:

    should_see "Welcome", :within => "#greeting"

At the moment, the `:within` keyword is the only accepted scope; the locator
you pass to this should be in whatever format your `Capybara.default_selector`
is set to. Other keywords like `:before` or `:after` may be supported in future
revisions.


Development
-----------

If you'd like to hack on Kelp, first fork and clone this repository. Then install
[bundler](http://gembundler.com/):

    $ gem install bundler

And then install Kelp's dependencies (specified in `Gemfile`):

    $ cd /path/to/kelp
    $ bundle install

It's a good idea to use [RVM](http://rvm.beginrescueend.com/) with a new gemset
to keep things tidy.

If you make changes that you'd like to share, push them into your Kelp fork,
then submit a pull request.


Testing
-------

Kelp comes with a `Rakefile`, so you can run the RSpec tests like so:

    $ rake spec

Since this project is fairly immature and unstable, you can probably expect
some failures. Wanna help fix them?

You can also generate an [rcov](http://eigenclass.org/hiki.rb?rcov) coverage
report via:

    $ rake rcov

This will write an HTML report to `coverage/index.html`.


Future plans
------------

* Write Cucumber integration tests
* Support other stuff besides Caypbara
* Turn the project into a proper Rails plugin, with generators
* Create a gem


Copyright
---------

Copyright (c) 2010 Eric Pierce, released under the MIT license.
See MIT-LICENSE for details.

