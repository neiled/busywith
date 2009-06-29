$(document).ready(function(){
  $("#progress_slider").slider({
    min: 0,
    max: 100,
    step: 5,
    slide: function(event, ui) {$("#percent_complete").val(ui.value+"%");}
  });
  $("#progress_slider").slider("value", $("#percent_complete").val().split("%")[0]);
});
