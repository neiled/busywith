$(this).everyTime(10000, function() {
  $.get(this.href,{last_updated : last_time },null,'script');
  // alert(last_time)
  }
);