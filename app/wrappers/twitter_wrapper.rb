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

  def friends_array
    @client.friend_ids(@pretendee.twitter).to_a
  end


  def last_200_friend_descriptions
    @client.friends('elainapolson', count: 200).attrs[:users].map {|friend| friend[:description]}
  end

#doesnt work
  # def get_all_descriptions
  #   start = 0
  #   finish = 200
  #   descriptions = []
  #   begin 
  #     while descriptions.length <= @client.friend_ids.count
  #       @client.friend_ids.sort[start..finish].each do |id| 
  #         descriptions << @client.user(id).description
  #       end
  #       start += 200
  #       finish += 200
  #     end
  #   rescue Twitter::Error::TooManyRequests => error
  #     sleep error.rate_limit.reset_in + 1
  #     retry
  #   end
  # end

  # def collect_with_max_friend_id(collection=[], max_id=nil, &block)
  #   response = yield(max_id)
  #   collection += response
  #   response.empty? ? collection.flatten : collect_with_max_friend_id(collection, response.last[:id] - 1, &block)
  # end

  # def get_all_friends(user)
  #   begin
  #     collect_with_max_friend_id do |max_id|
  #       options = {count: 200}
  #       options[:max_id] = max_id unless max_id.nil?
  #       @client.friends(user, options).attrs[:users].sort_by{|u| u[:id]}.reverse
  #     end
      
  #   rescue Twitter::Error::TooManyRequests => error
  #     sleep error.rate_limit.reset_in + 1
  #     retry
  #   end
  # end

  # def all_friends_bios(user)
  #   get_all_friends(user).map {|tweet| tweet.text}
  # end


  def all_friends(user)
    start = 0
    finish = 99
    friends = []
    while friends.length <= @client.friend_ids.count
      options = @client.friend_ids(user).to_a[start..finish]
      @client.users(options).each do |u|
        friends << u
      end
      start += 100
      finish += 100
    end
    friends
  end

  def all_descriptions(user)
    all_friends(user).map do |friend|
      if friend[:description]
        friend[:description]
      end
    end
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

