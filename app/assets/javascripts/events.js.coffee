$ ->
  $('.update-enrollment').change ->
    $select = $(@)
    $form = $select.parent 'form'
    data = $form.serialize()

    if !$select.val()
      return false

    $select.prop 'disabled', true
    $select.parents('tr').find('.bartenders_event span').fadeOut ->
      $.ajax
        type: 'POST'
        url: $form.prop 'action'
        data: data,
        success: ->
          $select.prop 'disabled', null
