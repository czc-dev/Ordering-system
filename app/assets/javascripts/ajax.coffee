ajaxDetailsHandler = ->
  # ajax#details
  $('#ajax_details_form select#set_id').change (_) ->
    $('#ajax_details_form').submit()

  # ajax#add_details
  $('#ajax_add_details_form').on 'submit', (e) ->
    e.preventDefault()

  # ajax#order_inspections
  $('#inspections_index_form #cancelled').change (_) ->
    $('#inspections_index_form').submit()

$(document).ready(ajaxDetailsHandler)
$(document).on('turbolinks:load', ajaxDetailsHandler)
