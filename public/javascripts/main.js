$(document).ready(function() {

  var padHeight = ( $(window).height() - 150 ) / 2 ;
  $('.grid').height(padHeight);

  $(window).resize(function() {
    padHeight = ( $(window).height() - 150 ) / 2 ;
    $('.grid').height(padHeight);
  });

});