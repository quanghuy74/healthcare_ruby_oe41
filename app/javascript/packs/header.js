$(function () {
  $(window).on('scroll', function () {
      if ( $(window).scrollTop() > 10 ) {
          $('.header-area').addClass('sticky-bar');
      } else {
          $('.header-area').removeClass('sticky-bar');
      }
  });
});
