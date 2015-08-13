class PusherWrapper

require 'pusher'

  def initialize
    @client = client
  end

  def client
    Pusher::Client.new({
     app_id: ENV['pusher_app_id'],
     key: ENV['pusher_key'],
     secret: ENV['pusher_secret']
    })
  end

end