var setDailyOccurance, setMonthlyOccurance, setSelectOccurance, setWeeklyOccurance, showManageCredits, showStats;

this.showStats = showStats = function(user_id) {
  event.preventDefault();
  if ($("#stats-" + user_id).is(":hidden")) {
    $("#stats-" + user_id).fadeIn("fast");
    return $("#statsShow-" + user_id).html("<a href=\"#\" class=\"i icon-chevron-up btn\" onclick=\"showStats(" + user_id + ");\"></a>");
  } else {
    $("#stats-" + user_id).fadeOut("fast");
    return $("#statsShow-" + user_id).html("<a href=\"#\" class=\"i icon-chevron-down btn\" onclick=\"showStats(" + user_id + ");\"></a>");
  }
};

this.setMonthlyOccurance = setMonthlyOccurance = function() {
  if ($('#monthly').is(':checked')) {
    $('#weekly').attr("checked", false);
    $('#daily').attr("checked", false);
    $('#sunday').attr("checked", false);
    $('#monday').attr("checked", false);
    $('#tuesday').attr("checked", false);
    $('#wednesday').attr("checked", false);
    $('#thursday').attr("checked", false);
    $('#friday').attr("checked", false);
    return $('#saturday').attr("checked", false);
  }
};

this.setWeeklyOccurance = setWeeklyOccurance = function() {
  if ($('#weekly').is(':checked')) {
    $('#monthly').attr("checked", false);
    $('#daily').attr("checked", false);
    $('#sunday').attr("checked", false);
    $('#monday').attr("checked", false);
    $('#tuesday').attr("checked", false);
    $('#wednesday').attr("checked", false);
    $('#thursday').attr("checked", false);
    $('#friday').attr("checked", false);
    return $('#saturday').attr("checked", false);
  }
};

this.setDailyOccurance = setDailyOccurance = function() {
  if ($('#daily').is(':checked')) {
    $('#weekly').attr("checked", false);
    $('#monthly').attr("checked", false);
    $('#sunday').attr("checked", false);
    $('#monday').attr("checked", false);
    $('#tuesday').attr("checked", false);
    $('#wednesday').attr("checked", false);
    $('#thursday').attr("checked", false);
    $('#friday').attr("checked", false);
    return $('#saturday').attr("checked", false);
  }
};

this.setSelectOccurance = setSelectOccurance = function() {
  if ($('#sunday').is(':checked') || $('#monday').is(':checked') || $('#tuesday').is(':checked') || $('#wednesday').is(':checked') || $('#thursday').is(':checked') || $('#friday').is(':checked') || $('#saturday').is(':checked')) {
    $('#daily').attr("checked", false);
    $('#weekly').attr("checked", false);
    return $('#monthly').attr("checked", false);
  }
};

this.showManageCredits = showManageCredits = function(user_id) {
  event.preventDefault();
  if ($("#manageCredits-" + user_id).is(":hidden")) {
    return $("#manageCredits-" + user_id).fadeIn("fast");
  } else {
    return $("#manageCredits-" + user_id).fadeOut("fast");
  }
};