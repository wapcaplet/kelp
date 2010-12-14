Capybara
========

This library includes the following helper modules for Capybara_:

.. _Capybara: http://github.com/jnicklas/capybara

.. toctree::
    :maxdepth: 2

    web_helper
    form_helper

To use all of them in your Cucumber tests, do:

.. code-block:: ruby

  require 'kelp/capybara'

Or just require the modules you need:

.. code-block:: ruby

  require 'kelp/capybara/web_helper'
  require 'kelp/capybara/form_helper'

Then add them to Cucumber's ``World``:

.. code-block:: ruby

  World(WebHelper)

