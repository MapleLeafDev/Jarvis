// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require mobile
//= require bootstrap
//= require Chart.bundle
//= require chartkick
//= require credit_card_form
//= require_tree .

$(document).bind("mobileinit", function(){
  $.mobile.loadingMessage = false;
});

$(document).ready(function(){
  setTimeout(function(){$('.flash').fadeOut("1000ms")},2000);

  $('.location').click(function(event) {
     event.preventDefault();
     var url = this.href
     if(url != '#'){
       window.location = url;
     }
  });

  // Enables popover
  $('.popover-who').popover({ html : true });

  $('.stripe-button-el').removeClass('stripe-button-el').addClass('btn btn-info').text('Create Account')

  $('.carousel').each(function(){
      $(this).carousel({
          interval: false
      });
  });

	var offset = 300,
		offset_opacity = 1200,
		scroll_top_duration = 700,
		$back_to_top = $('.cd-top');

	$(window).scroll(function(){
		( $(this).scrollTop() > offset ) ? $back_to_top.addClass('cd-is-visible') : $back_to_top.removeClass('cd-is-visible cd-fade-out');
		if( $(this).scrollTop() > offset_opacity ) {
			$back_to_top.addClass('cd-fade-out');
		}
	});

	$back_to_top.on('click', function(event){
		event.preventDefault();
		$('body,html').animate({
			scrollTop: 0 ,
		 	}, scroll_top_duration
		);
	});

  $('.num').click(function () {
    var cell = $(this);
    var text = cell.text();
    var pin = $('#pin');
    cell.fadeTo(100, 0.1).fadeTo(200, 1.0);
    pin.val(pin.val() + text);
  });
  $('.clear').click(function () {
    $(this).fadeTo(100, 0.1).fadeTo(200, 1.0);
    var pin = $('#pin');
    pin.val("");
  });
  $('.submit').click(function () {
    $(this).fadeTo(100, 0.1).fadeTo(200, 1.0);
    $("form").submit();
  });
});

function toggleUser( id ) {
  $.get("/users/" + id + "/toggle")
}
