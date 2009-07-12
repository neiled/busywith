Date.format = 'mm/dd/yyyy';
$(document).ready(function() {
  var current_color = $(".flash_message").css("color");
  //alert("here");
  $(".flash_message").animate({color:"#3C3"}, 1000).animate({color:current_color}, 1000);
});


