$(document).ready(function() {
  // this absolutely should be a separate file.
  $.getJSON('/contact/grandma', function(json, textStatus) {
    console.log(json.name);
    console.log(json.number);
    console.log(json.lastcall);
  });

  // more analytics! morlytics. manalytics.
  mixpanel.track('access page');

  var singlePad = false; // track whether we've expanded to a single pad

  // We want to size the four dialing pad surfaces continually with
  // window size so they're always visible and always large
  // We'll trigger this on load and on viewport resize.
  // n.b. the line-height readjustments vertically center text 
  // within each pad surface.
  function getPadHeight() { return Math.max(($(window).height() - 100) / 2, 30); }

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
    if(!singlePad) {  // don't run a dialout if one is already in progress
      var target = $(this);
      mixpanel.track('outgoing call');
      singlePad = true;

      // prepare to animate
      var origLocation = $(this).offset();

      $('.pad').not(this).fadeOut();
      $(this).fadeOut().find('.person').prepend("Calling ").append("...");

      $.get('/elder-tips', function(data) {
        target.find('.tips').prepend(data).fadeIn();
      })

      var newHeight = $(window).height() - 100;

      $(this).find('.person').css('padding', '20px');
      $(this).fadeIn()
             .animate({'top': 0, 'height': newHeight,
                       'line-height': 'normal',
                       'width': '100%'}, 1000);  // 'line-height': newHeight, 
      // $.post('/call', "number=+16175002301", function(data, textStatus, xhr) {
      //   target.html("Calling someone!");
      // });
    }
  });

});