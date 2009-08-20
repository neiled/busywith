$(document).ready(function() {
  $("#new_project").ajaxForm({
    // target identifies the element(s) to update with the server response 
    //target: '#project_list',
    dataType: 'script'
    // success identifies the function to invoke when the server response 
    // has been received; here we apply a fade-in effect to the new content 
    //success: function() { $('#project_list').fadeIn('slow'); }
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
});


$(this).everyTime(5000, function() {
  $.get(this.href,null,null,'script');
  }
);