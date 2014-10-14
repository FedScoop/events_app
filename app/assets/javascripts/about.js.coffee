# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

delay = (ms, func) -> setTimeout func, ms

flashMessage = ->
  $flash = $(".flash-message")
  if $flash
    delay 3000, ->
      $flash.fadeOut 1000

$ ->
  flashMessage()
