class TwitterWrapper
  attr_reader :client

  def initialize(pretendee)
     @pretendee = pretendee
     @client = create_client
  end


  def word_count_histogram
    words = (favorites_text + all_tweets_text + all_descriptions_text).flatten.join(' ').split(' ')
    frequency = Hash.new(0)
    words.each { |word| frequency[word.downcase] += 1 }
    commonwords = ["the", "and", "of", "a", "to", "is", "in", "its", "The", "on", "as", "for", "has", "will", "As", "or", "have", "while", "While", "that", "out", "such", "also", "by", "said", "with", "than", "only", "into", "an", "one", "other", "but", "for", "from", "<br />", "i", "more", "about", "About", "again", "Again", "against", "all", "are", "at", "be", "being", "been", "can", "could", "did", "do", "don't", "down", "up", "each", "few", "get", "got", "had", "have", "has", "he", "her", "she", "he", "it", "we", "they", "if", "thus", "it's", "hers", "his", "how", "why", "when", "where", "just", "like", "you", "me", "my", "most", "more", "no", "not", "yes", "off", "once", "only", "our", "out", "over", "under", "own", "then", "some", "these", "there", "then", "this", "those", "too", "through", "between", "until", "very", "who", "with", "wouldn't", "would", "was", "were", "itself", "himself", "herself", "which", "make", "during", "before", "after", "if", "any", "become", "around", "several", "them", "their", "however", "http", "https", "com", "co", "&", "-", "@", "rt", "+", "|", "so", "your", "i'm", "what", "new", "1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "we're", "//", "it", "i've", "oh", "it.", "...", "&" ]
    frequency = frequency.select {|word, count| !commonwords.include? word}

    frequency = frequency.map do |word, count| 
      {text: word, weight: count}
    end
    frequency = frequency.sort_by{|hash| hash[:weight]}.reverse[0..200]

  end

  def create_client
    Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["twitter_key"]
      config.consumer_secret     = ENV["twitter_secret"]
      config.access_token        = ENV["twitter_access_token"]
      config.access_token_secret = ENV["twitter_access_token_secret"]
    end
  end
  
  def favorites_text
    favorites.map {|tweet| tweet.text}
  end

  def favorites
    @client.favorites(@pretendee.twitter).collect {|favorite| favorite}
  end

  def all_tweets_text
    get_all_tweets.map {|tweet| tweet.text}
  end

  def get_all_tweets
    begin
      collect_with_max_id do |max_id|
        options = {count: 200, include_rts: true}
        options[:max_id] = max_id unless max_id.nil?
        @client.user_timeline(@pretendee.twitter, options)
      end
      
    rescue Twitter::Error::TooManyRequests => error
      sleep error.rate_limit.reset_in + 1
      retry
    end
  end

  def collect_with_max_id(collection=[], max_id=nil, &block)
    response = yield(max_id)
    collection += response
    response.empty? ? collection.flatten : collect_with_max_id(collection, response.last.id - 1, &block)
  end

  def all_descriptions_text
    all_friends.collect {|t| t.description}
  end

  def all_friends
    friend_ids = all_friend_ids
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
    friends.flatten.select {|d| d.description.class == String}
  end

  def all_friend_ids
    @client.friend_ids(@pretendee.twitter).to_a
  end

  def popular_hashtag_tweets(hashtag)
    tweets_with_links = @client.search(hashtag, type: "popular").attrs.first[1].select do |tweet|
      tweet[:entities][:urls] 
    end  
  end

  def hashtag_links(hashtag)
    url_entity_array = popular_hashtag_tweets(hashtag).collect do |tweet|
      tweet[:entities][:urls]
    end.flatten
    binding.pry

    url_entity_array.collect do |entity|
      entity[:expanded_url]
    end
  end

end