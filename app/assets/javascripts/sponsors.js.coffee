# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

sponsorWaitingOverlay = ->
  idList = [$('#new-sponsor-form'), $('#edit-sponsor-form')]
  $.each idList, (index, form)->
    form.submit ->
      $('.form').hide()
      $('.wait-overlay').show()
      true

$ ->
  sponsorWaitingOverlay()
