$(function() {
  $('#signup').bind("ajax:success", function(event, data, status, xhr){
    $('#flash-messages').html(data);
    console.log(data);
  })
});



