Kelp
====

This is the documentation for [Kelp](http://github.com/wapcaplet/kelp), a
collection of helpers that makes it easier to write step definitions for
[Cucumber](http://cukes.info). The Kelp gem is hosted on
[Rubygems](http://rubygems.org/gems/kelp), so you can install it with:

    $ gem install kelp

The name "Kelp" is a contraction of "Cuke Helpers". It was chosen because it's
short, easy to remember, and is in keeping with the theme of greenish plants.
Kelp is licensed under the
[MIT License](http://www.opensource.org/licenses/mit-license.php).

Please use the [issue tracker](http://github.com/wapcaplet/kelp/issues)
to report any bugs or feature requests.


Usage
-----

To use Kelp's helpers in your Cucumber step definitions, simply `require` the
helper module you're interested in:

    require 'kelp/visibility'

Then add the relevant modules to Cucumber's `World`:

    World(Kelp::Visibility)

Many of the provided helpers are designed to make it easier to do things you
might otherwise be tempted to do with nested step definitions. For example, if
you need to verify the presence of several text strings on a webpage, you might
have a step definition like this:

    Then /^I should see the login page$/ do
      Then %{I should see "Welcome"}
      And %{I should see "Thanks for visiting"}
      And %{I should see "Login"}
    end

Using the provided helper method `should_see`, you can do this instead:

    Then /^I should see the login page$/ do
      should_see "Welcome"
      should_see "Thanks for visiting"
      should_see "Login"
    end

Or even this:

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

    When %{I follow "Login"}
    And %{I fill in "Username" with "skroob"}
    And %{I fill in "Password" with "12345"}
    And %{I press "Log me in"}

translates to this:

    follow "Login"
    fill_in_fields \
      "Username" => "skroob",
      "Password" => "12345"
    press "Log me in"

Several methods also accept keywords to define the scope of an action. For
instance, if you want to look within an element with id="greeting"`, do:

    should_see "Welcome", :within => "#greeting"

At the moment, the `:within` keyword is the only accepted scope; the locator
you pass to this should be in whatever format your `Capybara.default_selector`
is set to. Other keywords like `:before` or `:after` may be supported in future
revisions.


Development
-----------

If you'd like to hack on Kelp, first fork the {http://github.com/wapcaplet/kelp
repository}, then clone your fork:

    $ git clone git://github.com/your_username/kelp.git

Install [bundler](http://gembundler.com/):

    $ gem install bundler

Then install Kelp's dependencies (specified in `Gemfile`):

    $ cd /path/to/kelp
    $ bundle install

It's a good idea to use [RVM](http://rvm.beginrescueend.com/)
with a new gemset to keep things tidy.

If you make changes that you'd like to share, push them into your Kelp fork,
then [submit a pull request](http://github.com/wapcaplet/kelp/pulls).


Testing
-------

Kelp comes with a `Rakefile`, so you can run the RSpec tests like so:

    $ rake spec

You can also generate an [rcov](http://eigenclass.org/hiki.rb?rcov)
coverage report via:

    $ rake rcov

This will write an HTML report to `coverage/index.html`.


Future plans
------------

* Write Cucumber integration tests
* Support other stuff besides Capybara
* Turn the project into a proper Rails plugin, with generators


Copyright
---------

The MIT License

Copyright (c) 2010 Eric Pierce

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
