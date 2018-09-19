# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

inspectionsAjaxIndex = ->
  $('#inspections_index_form #cancelled').change (_) ->
    $('#inspections_index_form').submit()

$(document).ready(inspectionsAjaxIndex)
$(document).on('turbolinks:load', inspectionsAjaxIndex)
