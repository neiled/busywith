$(document).ready(function() {
  $("#new_project").ajaxForm({
    // target identifies the element(s) to update with the server response 
    //target: '#project_list',
    dataType: 'script'
    // success identifies the function to invoke when the server response 
    // has been received; here we apply a fade-in effect to the new content 
    //success: function() { $('#project_list').fadeIn('slow'); }
  })
});