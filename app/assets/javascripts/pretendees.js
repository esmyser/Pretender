$(function(){

  $("#email-form").on('submit', '.newsletter-form', function(e){
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
    })
  });

  $("#email-form").on('submit', '#edit_report', function(e){
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
    })
  });

  $("#email-form").on('submit', '#new_report', function(e){
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
    })
  });

});