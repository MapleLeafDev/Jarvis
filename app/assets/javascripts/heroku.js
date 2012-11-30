function showStats(user_id){
  event.preventDefault();
  if ($("#stats-" + user_id).is(":hidden")) {
    $("#stats-" + user_id).fadeIn("fast");
    return $("#statsShow-" + user_id).html("<a href=\"#\" class=\"i icon-chevron-up btn\" onclick=\"showStats(" + user_id + ");\"></a>");
  } else {
    $("#stats-" + user_id).fadeOut("fast");
    return $("#statsShow-" + user_id).html("<a href=\"#\" class=\"i icon-chevron-down btn\" onclick=\"showStats(" + user_id + ");\"></a>");
  }
};

function setMonthlyOccurance(){
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

function setWeeklyOccurance(){
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

function setDailyOccurance(){
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

function setSelectOccurance(){
  if ($('#sunday').is(':checked') || $('#monday').is(':checked') || $('#tuesday').is(':checked') || $('#wednesday').is(':checked') || $('#thursday').is(':checked') || $('#friday').is(':checked') || $('#saturday').is(':checked')) {
    $('#daily').attr("checked", false);
    $('#weekly').attr("checked", false);
    return $('#monthly').attr("checked", false);
  }
};

function showManageCredits(user_id){
  event.preventDefault();
  if ($("#manageCredits-" + user_id).is(":hidden")) {
    return $("#manageCredits-" + user_id).fadeIn("fast");
  } else {
    return $("#manageCredits-" + user_id).fadeOut("fast");
  }
};