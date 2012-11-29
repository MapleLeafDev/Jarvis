jQuery ->
  $("a[rel=popover]").popover()
  $(".tooltip").tooltip()
  $("a[rel=tooltip]").tooltip()

@showStats = showStats = (user_id) ->
  event.preventDefault()
  if $("#stats-" + user_id).is(":hidden")
    $("#stats-" + user_id).fadeIn "fast"
    $("#statsShow-" + user_id).html "<a href=\"#\" class=\"i icon-chevron-up btn\" onclick=\"showStats(" + user_id + ");\"></a>"
  else
    $("#stats-" + user_id).fadeOut "fast"
    $("#statsShow-" + user_id).html "<a href=\"#\" class=\"i icon-chevron-down btn\" onclick=\"showStats(" + user_id + ");\"></a>"

@setMonthlyOccurance = setMonthlyOccurance = ->
  if $('#monthly').is(':checked')
    $('#weekly').attr "checked", false
    $('#daily').attr "checked", false
    $('#sunday').attr "checked", false
    $('#monday').attr "checked", false
    $('#tuesday').attr "checked", false
    $('#wednesday').attr "checked", false
    $('#thursday').attr "checked", false
    $('#friday').attr "checked", false
    $('#saturday').attr "checked", false

@setWeeklyOccurance = setWeeklyOccurance = ->
  if $('#weekly').is(':checked')
    $('#monthly').attr "checked", false
    $('#daily').attr "checked", false
    $('#sunday').attr "checked", false
    $('#monday').attr "checked", false
    $('#tuesday').attr "checked", false
    $('#wednesday').attr "checked", false
    $('#thursday').attr "checked", false
    $('#friday').attr "checked", false
    $('#saturday').attr "checked", false

@setDailyOccurance = setDailyOccurance = ->
  if $('#daily').is(':checked')
    $('#weekly').attr "checked", false
    $('#monthly').attr "checked", false
    $('#sunday').attr "checked", false
    $('#monday').attr "checked", false
    $('#tuesday').attr "checked", false
    $('#wednesday').attr "checked", false
    $('#thursday').attr "checked", false
    $('#friday').attr "checked", false
    $('#saturday').attr "checked", false

@setSelectOccurance = setSelectOccurance = ->
  if $('#sunday').is(':checked') || $('#monday').is(':checked') || $('#tuesday').is(':checked') || $('#wednesday').is(':checked') || $('#thursday').is(':checked') || $('#friday').is(':checked') || $('#saturday').is(':checked')
    $('#daily').attr "checked", false
    $('#weekly').attr "checked", false
    $('#monthly').attr "checked", false