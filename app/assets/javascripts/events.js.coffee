# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

addAgendaItem = ->
  $add = $ ".add-agenda-item"
  $(".add-agenda").on "click", ".add-agenda-item", (e) ->
    e.preventDefault()
    counter = parseInt $(".agenda-counter").html()
    $(".add-agenda").append $(".new-agenda-item").html()
    $new = $ $(".add-agenda .agenda-form").last()
    $new.children().each (i) ->
      if String($(this).attr("id")).indexOf("time_") > -1
        $(this).attr("id", "agenda_" + counter + "_time_")
        $(this).attr("name", "agenda[" + counter + "[time]]")
      else if String($(this).attr("id")).indexOf("title_") > -1
        $(this).attr("id", "agenda_" + counter + "_title_")
        $(this).attr("name", "agenda[" + counter + "[title]]")
      else if String($(this).attr("id")).indexOf("_speaker") > -1
        $(this).attr("id", "agenda_" + counter + "_speaker")
        $(this).attr("name", "agenda[" + counter + "[speaker]]")
    counter += 1
    $(".agenda-counter").html counter

delAgendaItem = ->
  $del = $ ".del-agenda-item"
  $(".add-agenda").on "click", ".del-agenda-item", (e) ->
    e.preventDefault()
    $item = $(e.target).parent()
    $item.hide ->
      $item.remove()

$ ->
  addAgendaItem()
  delAgendaItem()
