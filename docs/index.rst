.. Kelp documentation master file, created by
   sphinx-quickstart on Sun Dec 12 16:07:03 2010.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.

Kelp
====

This is the documentation for Kelp_, a collection of helpers that makes it
easier to write step definitions for Cucumber_.

The name "Kelp" is a contraction of "Cuke Helpers". It was chosen because it's
short, easy to remember, and is in keeping with the theme of greenish plants.

.. _Kelp: http://github.com/wapcaplet/kelp
.. _Cucumber: http://cukes.info/


Contents
--------

.. toctree::
    :maxdepth: 2

    usage
    development
    testing


Installation
------------

You can obtain the source code from Github_. As of now, there is no gem or
packaged release, so just clone the repository like::

    $ git clone git://github.com/wapcaplet/kelp.git

Until Kelp grows a saner approach for installation (such as a Rails
generator), just copy files from ``lib`` into your ``features/step_definitions``
folder as you need them, and add them to Cucumber's world, i.e.::

    World(WebHelper)
    World(FormHelper)

.. _Github: http://github.com/wapcaplet/kelp


Future plans
------------

* Write Cucumber integration tests
* Support other stuff besides Caypbara
* Turn the project into a proper Rails plugin, with generators
* Create a gem


