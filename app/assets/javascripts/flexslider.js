jQuery(document).ready(function($) {

  
    $('.flexslider').flexslider({
      controlNav: false,
      animation: 'slide',
      keyboard: false
    });

    setTimeout(
      fixFlexslider()
      , 3000
    );

    function fixFlexslider() {
      // FIX FOR FLEXSLIDER
      // Vertically center flexslider slides.
      // Get container size.
      var maxHeight = $('ul.slides').first().height();
      $('.flexslider .slides li').each(function() {
        // Each slide's height.
        slideHeight = $(this).height();
        // Calculate top padding of each slide as half the difference between
        // its height and the container height.
        $(this).css('padding-top', (maxHeight - slideHeight)/2);
      });   
    }

});

