require 'open-uri'
require 'oauth'
class TwitterWrapper

  attr_reader :client

  def initialize(pretendee)
     @pretendee = pretendee
     @client = create_client
  end

  def create_client
    Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["twitter_consumer_key"]
      config.consumer_secret     = ENV["twitter_consumer_secret"]
      config.access_token        = ENV["twitter_access_token"]
      config.access_token_secret = ENV["twitter_access_token_secret"]
    end
  end

  def favorites
    @client.favorites(@pretendee.twitter).collect {|favorite| favorite}
  end

  def all_friend_ids(user)
    @client.friend_ids(user).to_a
  end

  def all_friends(user)
    friend_ids = all_friend_ids(user)
    start = 0
    finish = 99
    friends = []
    while friends.flatten.length < friend_ids.length
      if finish > friend_ids.length
        finish = (friend_ids.length - 1)
      end
      options = friend_ids[start..finish]
      friends << @client.users(options)
      start += 100
      finish += 100
    end
    friends.flatten.select {|d| d[:description].class == String}
  end

  def all_descriptions(user)
    all_friends(user).collect {|t| t[:description]}
  end

  def collect_with_max_id(collection=[], max_id=nil, &block)
    response = yield(max_id)
    collection += response
    response.empty? ? collection.flatten : collect_with_max_id(collection, response.last.id - 1, &block)
  end

  def get_all_tweets(user)
    begin
      collect_with_max_id do |max_id|
        options = {count: 200, include_rts: true}
        options[:max_id] = max_id unless max_id.nil?
        @client.user_timeline(user, options)
      end
      
    rescue Twitter::Error::TooManyRequests => error
      sleep error.rate_limit.reset_in + 1
      retry
    end
  end

  def all_tweets_text
    get_all_tweets("#{@pretendee.twitter}").map {|tweet| tweet.text}
  end

end

