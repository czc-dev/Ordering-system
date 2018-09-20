ajaxDetailsHandler = ->
  $('#ajax_details_form select#set_id').change (_) ->
    $('#ajax_details_form').submit()

  $('#ajax_add_details_form').on 'submit', (e) ->
    e.preventDefault()

$(document).ready(ajaxDetailsHandler)
$(document).on('turbolinks:load', ajaxDetailsHandler)
