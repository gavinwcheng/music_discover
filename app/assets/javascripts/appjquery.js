$(document).ready(function() {
  console.log('working');

  // for(i=0; i<8; i++) {
  //   $('#grape_' + i).hide();
  // };

  // $('.button_box').hide();

  for(i = 0; i <= 19; i++){
    $('#collapse' + i).collapse("hide");
  };

  var delay = 0;
  $('.grape_fill').each(function() {
    $(this).delay(delay).animate({
      opacity:0
    }, 100);
    delay += 200;
  });

  $('.leaf_fill').delay(1800).animate({
    opacity:0
  }, 500);

  $('#sign_in_box').delay(2500).animate({
    opacity:1
  }, 500);

  $('#generate_playlist_box').delay(500).animate({
    opacity:1
  }, 500);

  $('#welcome_logo').delay(500).animate({
    opacity:1
  }, 500);

  $('#welcome_box').delay(500).animate({
    opacity:1
  }, 500);

});