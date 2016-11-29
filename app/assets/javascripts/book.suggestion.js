$(document).ready(function(){
  var form = $('#book_suggestion');
  var button = $(form).find('input[type=submit]');
  $(button).click(function(e){
    $('.alert.alert-error').text();
    e.preventDefault();
    $.ajax({
      url: 'http://localhost:3000/api/v1/public/book_suggestions',
      type: 'POST',
      data: $(form).serialize(),
      success: function(data, status) {
        $('.book-suggestions-title').append('<ol>' + 'Title: '  + data.title + '</br>' + 'Author: '  + data.author +  '</ol>');
      },
      error: function(data, status) {
        $.each(data.responseJSON.error, function(value, other) {
          $('.alert.alert-error').text(value + ' '  + other);
        })
      }
    })
    return false;
  });
})
