$(function(){
  $("#new_topic").submit(function(event){
    event.preventDefault();
    event.stopPropagation();

    var pusher = new Pusher('01e0b165f94105952d85');
    var channel = pusher.subscribe("whatever");
    
    channel.bind('finished', function(data) {
      var html = "<div class='image-wrapper col-sm-3 nopadding'><img src='http://www.bestbritishsweets.co.uk/user/products/large/topic.jpg' class='img-responsive'><div class='image-overlay'><p><a href='http://localhost:3000/users/" + data['topic']['user_id'] + "/topics/" + data['topic']['user_id'] + "'>" + data['topic']['name'] + "</a><br><br><a rel='nofollow' data-method='delete' href='http://localhost:3000/users/" + data['topic']['user_id'] + "/topics/" + data['topic']['user_id'] + "'>Delete</a></p></div></div>"
      
      $("#topics").children().last().remove();
      $("#topics").append(html);
      pusher.unsubscribe("whatever");
    });

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