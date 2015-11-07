$(document).ready(function() {
  console.log('working');

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

  var logoTarget = $('#logo_box');
  var logoTargetHeight = 200

  $(document).scroll(function(e){
      var scrollPercent = (logoTargetHeight - window.scrollY) / logoTargetHeight;
      if(scrollPercent >= 0){
          logoTarget.css('opacity', scrollPercent);
      }
  });

  var textTarget = $('#about_text');
  var textTargetHeight = 300

  $(document).scroll(function(e){
      var scrollPercent = 1 - ((textTargetHeight - window.scrollY) / textTargetHeight);
      if(scrollPercent >= 0){
          textTarget.css('opacity', scrollPercent);
      }
  });


});