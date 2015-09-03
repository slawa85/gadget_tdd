$(document).ready(function() {
  $('#list').click(function(event) {
    event.preventDefault();$('#gadgets .item').addClass('list-group-item');
  });
  $('#grid').click(function(event) {
    event.preventDefault();$('#gadgets .item').removeClass('list-group-item');$('#gadgets .item').addClass('grid-group-item');
  });

  $('.image-gallery').magnificPopup({
    delegate: 'a',
    type: 'image',
    closeOnContentClick: false,
    closeBtnInside: false,
    image: {
      verticalFit: true,
    },
    gallery: {
      enabled: true
    },
    zoom: {
      enabled: true,
      duration: 300,
    }
  });

});
