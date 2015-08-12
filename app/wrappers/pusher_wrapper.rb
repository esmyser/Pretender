class PusherWrapper

require 'pusher'

  def initialize
    @client = client
  end

  def client
    Pusher.configure do |config|
      config.app_id = ENV['pusher_app_id']
      config.key = ENV['pusher_key']
      config.secret = ENV['pusher_secret']
    end

    # Pusher::Client.new({
    #   app_id: ENV['pusher_app_id'],
    #   key: ENV['pusher_key'],
    #   secret: ENV['pusher_secret']
    # })
  end

end