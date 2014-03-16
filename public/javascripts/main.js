$(document).ready(function() {

  function getPadHeight() { return ($(window).height() - 200) / 2; }

  $('.grid').height(getPadHeight);

  $(window).resize(function() {
    $('.grid').height(getPadHeight());
  });

});