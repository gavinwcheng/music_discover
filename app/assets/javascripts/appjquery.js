$(document).ready(function($) {
  console.log('working');

  for(i=0; i<20; i++) {
    if(i % 2 == 0) {
      $('#heading' + i).css({"background-color": "#f3e5f9"});
      $('#collapse' + i).css({"background-color": "#f3e5f9"});
    } else {
      $('#heading' + i).css({"background-color": "#ebfaeb"});
      $('#collapse' + i).css({"background-color": "#ebfaeb"});
    };
  };

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


  $('.save_track_link').click(function() {
        $(this).text("Saved");
        $(this).css({"background-color":"#8944ca"})
  });

  $('.leaf_fill').delay(1800).animate({
    opacity:0
  }, 500);

  $('#sign_in_box').delay(2500).animate({
    opacity:1
  }, 500);

  $('.sign_out_notice').delay(2500).animate({
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

  $('#user_img').delay(500).animate({
    opacity:1
  }, 500);

  $('.playlist_area').delay(500).animate({
    opacity:1
  }, 500);

  $('.playlist_header').delay(500).animate({
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
