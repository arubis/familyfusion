$(document).ready(function() {
  var singlePad = false; // track whether we've expanded to a single pad

  // We want to size the four dialing pad surfaces continually with
  // window size so they're always visible and always large
  // We'll trigger this on load and on viewport resize.
  // n.b. the line-height readjustments vertically center text 
  // within each pad surface.
  function getPadHeight() { return Math.max(($(window).height() - 200) / 2, 30); }

  $('.pad').height(getPadHeight);
  $('.pad').css('line-height', getPadHeight() + "px");

  $(window).resize(function() {
    if(!singlePad) {
      $('.pad').height(getPadHeight());
      $('.pad').css('line-height', getPadHeight() + "px");
    }
  });

  // DIVs aren't actually buttons, but I want them to be.
  // 
  $('.pad').on('click tap', function() {
    var target = $(this);
    mixpanel.track('outgoing call');
    singlePad = true;

    // prepare to animate
    var origLocation = $(this).offset();

    $('.pad').not(this).fadeOut();
    $(this).fadeOut().prepend("Calling ").append("...");

    var newHeight = $(window).height() - 200;

    $(this).fadeIn()
           .animate({'top': 0, 'height': newHeight,
                     'line-height': newHeight, 
                     'width': '100%'}, 1000);
    // $.post('/call', "number=+16175002301", function(data, textStatus, xhr) {
    //   target.html("Calling someone!");
    // });
  });

});