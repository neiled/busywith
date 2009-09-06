var last_time = Date();

$(document).ready(function() {
  $("#new_project").ajaxForm({
    dataType: 'script'
  })
  
  $("#new_member").ajaxForm({
    dataType: 'script'
  })  
  
  //There's already an onclick so we want to get rid of it...
  $('.remove_project').removeAttr('onClick');
  
  $('.remove_project').live('click', function(event) {
    var deleteLink = $(this);
    if ( confirm("Are you sure you want to delete this project?") )
      $.ajax({
        url: this.href,
        type: 'post',
        dataType: 'script',
        data: { '_method' : 'delete'},      
        success: function(){deleteLink.parent().remove()}
      });
    return false;
  })
  
  $('.user_status_updated').live()  
});


