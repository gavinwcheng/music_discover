$(document).ready(function() {
  console.log('working');

  // for(i=0; i<8; i++) {
  //   $('#grape_' + i).hide();
  // };

  // $('.button_box').hide();

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

  var target = $('#logo_box');
  var targetHeight = target.outerHeight();

  $(document).scroll(function(e){
      var scrollPercent = ((targetHeight) - window.scrollY) / (targetHeight);
      if(scrollPercent >= 0){
          target.css('opacity', scrollPercent);
      }
  });


});