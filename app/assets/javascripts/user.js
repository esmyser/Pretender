$(function(){
  $("#new_topic").submit(function(event){
    event.preventDefault();
    event.stopPropagation();  

    var url = $(this).attr('action'),
        method = $(this).attr('method'),
        data = $(this).serializeArray();

    $.ajax({
      method: method,
      url: url,
      data: data,
      dataType: 'script'
    })
  });
});

