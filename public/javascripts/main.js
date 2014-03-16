$(document).ready(function() {
  var singlePad = false; // track whether we've expanded to a single pad

  function getPadHeight() { return Math.max(($(window).height() - 200) / 2, 30); }

  $('.pad').height(getPadHeight);
  $('.pad').css('line-height', getPadHeight() + "px")

  $(window).resize(function() {
    if(!singlePad) {
      $('.pad').height(getPadHeight());
      $('.pad').css('line-height', getPadHeight() + "px")
    }
  });

  // good lord I am exhausted. Just get one of these bloody things to
  // fire and clean it up in the morning, yeah?
  $('.pad').on('click tap', function() {
    var target = $(this);

    singlePad = true;

    // prepare to animate
    var origLocation = $(this).offset();

    $('.pad').not(this).fadeOut();
    $(this).fadeOut().prepend("Calling ").append("...")

    var newHeight = $(window).height() - 200;

    // $(this).prepend("Calling ").append("...");
    $(this).fadeIn()
           .animate({'top': 0, 'height': newHeight,
                     'line-height': newHeight, 
                     'width': '100%'}, 1000);
    // $.post('/call', "number=+16175002301", function(data, textStatus, xhr) {
    //   target.html("Calling someone!");
    // });
  });

});