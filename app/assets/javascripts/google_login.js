function onGoogleSignIn(googleUser){
  $.post("/api/v1/users/sessions/create_from_google", {
    id_token: googleUser.getAuthResponse().id_token
  })
    .done(function(data){
      $('#login-token').html(data.access_token);
    })
    .fail(function(){
      // TODO: ...
    });
}
