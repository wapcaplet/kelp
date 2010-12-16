``web_helper``
==============

This module includes helpers for basic webpage navigation and verification.

.. module:: WebHelper

.. function:: in_scope(scope)

    Execute a block of code inside a given scope. ``scope`` must be a ``Hash``
    of parameters that describes the context in which to execute the block.
    Currently this supports one scope expression, ``:within => locator``.

    Examples:

    .. code-block:: ruby

        in_scope :within => '#footer'
            click_link "Contact Us"
        end


.. function:: should_see(texts, scope={})

    Verify the presence of content on the page. Passes when all the given items
    are found on the page, and fails if any of them are not found.

    :param texts: ``String``, ``Regexp``, or array of ``String`` and ``Regexp``
    :param scope: Scoping keywords as understood by :func:`in_scope`

    Examples:

    .. code-block:: ruby

        should_see "Animaniacs"
        should_see ["Yakko", "Wakko", "Dot"]
        should_see "Baloney", :within => "#slacks"
        should_see /(Animaney|Totally Insaney|Pinky and the Brainy)/


.. function:: should_not_see(texts, scope={})

    Verify the absence of content on the page. Passes when none of the given
    items are found on the page, and fails if any of them are found.

    :param texts: ``String``, ``Regexp``, or array of ``String`` and ``Regexp``
    :param scope: Scoping keywords as understood by :func:`in_scope`


.. function:: follow(link, scope={})

    Follow a link on the page.

    :param link: Capybara locator expression (id, name, or link text)
    :param scope: Scoping keywords as understood by :func:`in_scope`

    Examples:

    .. code-block:: ruby

        follow "Login"
        follow "Contact Us", :within => "#footer"


.. function:: press(button, scope={})

    Press a button on the page.

    :param button: Capybara locator expression (id, name, or button text)
    :param scope: Scoping keywords as understood by :func:`in_scope`

    Examples:

    .. code-block:: ruby

        press "Cancel"
        press "Submit", :within => "#survey"


.. function:: should_see_in_same_row(texts)

    Verify that all items appear in the same table row. Passes if a ``tr``
    element exists containing all the given ``texts``, and fails if no such
    ``tr`` exists. The texts may be in any order in the row.

    :param texts: array of ``String``

    .. code-block:: ruby

        should_see_in_same_row ["Yakko", "Rob Paulsen"]
        should_see_in_same_row ["Wakko", "Jess Harnell"]
        should_see_in_same_row ["Dot", "Tress MacNeille"]


.. function:: should_not_see_in_same_row(texts)

    Verify that all items do not appear in the same table row. Passes if there
    is no ``tr`` containing all the given ``texts``, and fails if there exists
    such a ``tr``.

    :param texts: array of ``String``

    .. code-block:: ruby

        should_not_see_in_same_row ["Pinky", "Maurice LaMarche"]
        should_not_see_in_same_row ["Brain", "Rob Paulsen"]


.. function:: click_link_in_row(link, text)

    Follow a link in a table row.

    :param link: ``String`` content of the link to click
    :param text: ``String`` contained in the same row as the link

    Examples:

    .. code-block:: ruby

        click_link_in_row "Edit", "Pinky"


.. function:: should_be_disabled(element_id)

    Verify that the HTML element with the given ID exists, and has the
    ``disabled`` attribute.

    :param element_id: HTML ``id`` attribute of the element that should be disabled


.. function:: should_be_enabled(element_id)

    Verify that the HTML element with the given ID exists, and does not have
    the ``disabled`` attribute.

    :param element_id: HTML ``id`` attribute of the element that should be enabled

