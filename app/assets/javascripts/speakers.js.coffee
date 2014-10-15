# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

waitingOverlay = ->
  idList = [$('#new-speaker-form'), $('#edit-speaker-form')]
  $.each idList, (index, form)->
    form.submit ->
      $('.form').hide()
      $('.wait-overlay').show()
      true

$ ->

  $list = $(".speaker-list").imagesLoaded ->
    $list.isotope({
      itemSelector: '.speaker-card'
      layoutMode: 'fitRows'
    })
  waitingOverlay()

