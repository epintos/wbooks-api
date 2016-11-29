$(document).ready(function() {
  console.log("vamoooooos los pi")
  $('#book_suggestion').submit(function(e) {
    e.preventDefault();
    $.ajax({
      url: "http://localhost:3000/api/v1/public/book_suggestions", //$('#book_suggestion').attr('url'),
      method: 'POST',
      data: $('#book_suggestion').serialize(),
      success: function(data, status) {
        $('.errors').empty();
        $("#book_suggestion").trigger('reset')
        $('.suggestions-container').append('<h3>Suggestion Nº: ' + data.id + '</h3>')
        $('.suggestions-container').append('<div class=\"content-container\"><h4>Title: ' + data.title + '</h4></div>')
        $('.suggestions-container').append('<div class=\"content-container\"><h4>Author: ' + data.author + '</h4></div>')
        $('.suggestions-container').append('<div class=\"content-container\"><h4>Publisher: ' + data.publisher + '</h4></div>')
        $('.suggestions-container').append('<div class=\"content-container\"><h4>Year: ' + data.year + '</h4></div>')
        $('.suggestions-container').append('<div class=\"content-container\"><h4>Link: ' + data.link + '</h4></div>')
        $('.suggestions-container').append('<div class=\"content-container\"><h4>Price: ' + data.price + '</h4></div>')
        return false;
      }, error: function (data) {
        $('.errors').empty();
        if ( typeof data.responseJSON.error.title != 'undefined') {
          $('.errors').append('<li>Title: ' + data.responseJSON.error.title + '</li>')
        }
        if ( typeof data.responseJSON.error.author != 'undefined') {
          $('.errors').append('<li>Author: ' + data.responseJSON.error.author + '</li>')
        }
        if ( typeof data.responseJSON.error.link != 'undefined') {
          $('.errors').append('<li>Link: ' + data.responseJSON.error.link + '</li>')
        }
        return false;
      }
    });
  })
});
