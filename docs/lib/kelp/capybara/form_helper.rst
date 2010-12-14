``form_helper``
===============

This module includes helpers for filling in and verifying form content,
including text fields and dropdowns.

.. module:: FormHelper

.. function:: fill_in_fields(fields, scope={})

  Fill in multiple fields according to values in a ``Hash``.

  :param fields: ``Hash`` of ``"field" => "value"`` for each field to fill in
  :param scope: Scoping keywords as understood by :func:`WebHelper.in_scope`

  Examples:

  .. code-block:: ruby

    fill_in_fields "First name" => "Otto", "Last name" => "Scratchansniff"
    fill_in_fields "phone" => "303-224-7428", :within => "#home"


.. function:: fill_in_fields_within(selector, fields)

  Alias for ``fill_in_fields(fields, :within => selector)``


.. function:: field_should_be_empty(field)

  Verify that the given field is empty or ``nil``.


.. function:: dropdown_should_equal(dropdown, value)

  Verify that a dropdown has a given value selected.

  :param dropdown: Capybara locator for the dropdown (the ``select`` element)
  :param value: ``String`` value you expect to see as the currently-selected option


.. function:: dropdown_should_include(dropdown, values, scope={})

  Verify that a dropdown includes all of the given values.

  :param dropdown: Capybara locator for the dropdown (the ``select`` element)
  :param values: Visible values you expect to be able to select from the dropdown


.. function:: dropdown_value_should_equal(dropdown, value)

  Verify that a dropdown currently has the option with the given ``value``
  attribute selected. Note that this differs from
  :func:`dropdown_should_equal`, in that it looks at the actual ``value``
  attribute of the selected option, rather than its visible contents.

  :param dropdown: Capybara locator for the dropdown (the ``select`` element)
  :param value: Expected ``value`` attribute of the selected ``option``


.. function:: field_should_contain(field, value)

  Verify the contents of a text field.

  :param field: Capybara locator for the field (name, id, or label text)
  :param value: ``String`` you expect to see in the text field


.. function:: fields_should_contain(field_values, scope={})

  Verify one or more field values given in a ``Hash``.

  :param field_values: ``Hash`` of ``"field" => "value"`` for each field you want to verify
  :param scope: Scoping keywords as understood by :func:`WebHelper.in_scope`


.. function:: fields_should_contain_within(selector, field_values)

  Alias for ``fields_should_contain(field_values, :within => selector)``

