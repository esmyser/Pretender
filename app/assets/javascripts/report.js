$(function(){

  $("#email-form").on('submit', '.form-horizontal', function(e){
    e.preventDefault();
    e.stopPropagation();  
    
    var url = $(this).attr('action');
    var method = $(this).attr('method');
    var data = $(this).serializeArray();
    $.ajax({
      method: method,
      url: url,
      data: data,
      dataType: 'script'
    });
  });
  
});