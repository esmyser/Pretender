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
    });
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
    });
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
    });
  });

  $("#new_pretendee_topic").submit(function(event){
    event.preventDefault();
    event.stopPropagation();

    var pusher = new Pusher('01e0b165f94105952d85');
    // need to get figaro working
    var name = $("#the_user").text();
    var channel = pusher.subscribe(name);
    // need to set separate channels for each topic creation

    
    channel.bind('finished', function(data) {
      var url = window.location.href;
      var html = "<div class='image-wrapper col-sm-3 nopadding'><div class='square-div'><img src='" + data['topic']['image'] + "' class='img-responsive square-img'></div><div class='image-overlay'><p><a href='" + url + "/topics/" + data['topic']['id'] + "'>" + data['topic']['name'] + "</a><br><br><a rel='nofollow' data-method='delete' class='deleter' href='" + url + "/topics/" + data['topic']['id'] + "'>Delete</a></p></div></div>";
      $("#topics").children().last().remove();
      $("#topics").append(html);
      pusher.unsubscribe($("#the_user").text());
    });

    var url = $(this).attr('action'),
    method = $(this).attr('method'),
    data = $(this).serializeArray();

    $.ajax({
      method: method,
      url: url,
      data: data,
      dataType: 'script'
    });
  });


  $("#topics").on("click", ".deleter", function(e){
    e.stopPropagation();
    e.preventDefault();

    $.ajax({
      method: $(this).attr('data-method'),
      url: $(this).attr('href'),
      data: $(this).serializeArray(),
      dataType: 'script'
    });
    $(this).parents().eq(2).remove();
  });
});