ajaxHandlers = ->
  # ajax#details
  $('#ajax_details_form select#set_id').change (_) ->
    $('#ajax_details_form').submit()

  # ajax#add_details
  $('#ajax_add_details_form').on 'submit', (e) ->
    e.preventDefault()

  # ajax#patient_orders
  $('#orders_index_form select').change (_) ->
    $('#orders_index_form').submit()

  # ajax#order_inspections
  $('#inspections_index_form #canceled').change (_) ->
    $('#inspections_index_form').submit()

$(document).ready(ajaxHandlers)
$(document).on('turbolinks:load', ajaxHandlers)
