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
      if String($(this).attr("id")).indexOf("_time") > -1
        $(this).attr("id", "agenda_" + counter + "_time")
        $(this).attr("name", "agenda[" + counter + "[time]]")
      else if String($(this).attr("id")).indexOf("_title") > -1
        $(this).attr("id", "agenda_" + counter + "_title")
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

addSponsorItem = ->
  $(".add-sponsor").on "click", ".add-sponsor-item", (e) ->
    e.preventDefault()
    counter = parseInt $(".sponsor-counter").html()
    $(".add-sponsor").append $(".new-sponsor-item").html()
    $new = $ $(".add-sponsor .sponsor-form").last()
    $new.children().each (i) ->
      if String($(this).attr("id")).indexOf("_level") > -1
        $(this).attr("id", "sponsors_" + counter + "_level")
        $(this).attr("name", "sponsors[" + counter + "][level]")
    $new.find(".sponsor-column").children().each (i) ->
      if String($(this).attr("id")).indexOf("_sponsor_ids_") > -1
        $(this).attr("id", "sponsors_" + counter + "_sponsor_ids_")
        $(this).attr("name", "sponsors[" + counter + "][sponsor_ids][]")
    counter += 1
    $(".sponsor-counter").html counter

$ ->
  addAgendaItem()
  delAgendaItem()
  addSponsorItem()
