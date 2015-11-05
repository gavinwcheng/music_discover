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
    }, 200);
    delay += 300;
  });

  $('.leaf_fill').delay(2500).animate({
    opacity:0
  }, 500);

  $('.button_box').delay(3000).animate({
    opacity:1
  }, 500);

});