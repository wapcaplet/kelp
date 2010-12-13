Installing Kelp
===============

You can obtain the source code from Github_. As of now, there is no gem or
packaged release, so just clone the repository like::

    $ git clone git://github.com/wapcaplet/kelp.git

Until Kelp grows a saner approach for installation (such as a Rails
generator), just copy files from ``lib`` into your ``features/step_definitions``
folder as you need them, and add them to Cucumber's world, i.e.::

    World(WebHelper)
    World(FormHelper)

.. _Github: http://github.com/wapcaplet/kelp


