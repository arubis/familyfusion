$(document).ready(function() {

  function getPadHeight() { return Math.max(($(window).height() - 200) / 2, 30); }

  $('.pad').height(getPadHeight);
  $('.pad').css('line-height', getPadHeight() + "px")

  $(window).resize(function() {
    $('.pad').height(getPadHeight());
    $('.pad').css('line-height', getPadHeight() + "px")
  });

  // good lord I am exhausted. Just get one of these bloody things to
  // fire and clean it up in the morning, yeah?
  $('.pad').on('click tap', function() {
    var target = $(this);
    $.post('/call', "number=+16175002301", function(data, textStatus, xhr) {
      target.html("Calling someone!");
    });
  });

});