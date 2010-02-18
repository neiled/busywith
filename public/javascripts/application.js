Date.format = 'dd mmm yyyy';

setTimeout(function() {
    $('#flash_notice').fadeOut('slow');
}, 7000);

$(document).ready(function() {
  var current_color = $(".flash_message").css("color");
  //alert("here");
  $(".flash_message").animate({color:"black"}, 1000).animate({color:current_color}, 1000);
  
  $(".choose_team").change ( function() {
    window.location = this.value;
  });
});

// Always send the authenticity_token with ajax
$(document).ajaxSend(function(event, request, settings) {
    if ( settings.type == 'post' ) {
        settings.data = (settings.data ? settings.data + "&" : "")
                + "authenticity_token=" + encodeURIComponent( AUTH_TOKEN );
        request.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
    }
});

// When I say html I really mean script for rails
$.ajaxSettings.accepts.html = $.ajaxSettings.accepts.script;