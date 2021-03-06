class TwitterWrapper
  attr_reader :client, :words
  
  COMMON_WORDS = ["the", "and", "of", "a", "to", "is", "in", "its", "The", "on", "as", "for", "has", "will", "As", "or", "have", "while", "While", "that", "out", "such", "also", "by", "said", "with", "than", "only", "into", "an", "one", "other", "but", "for", "from", "<br />", "i", "more", "about", "About", "again", "Again", "against", "all", "are", "at", "be", "being", "been", "can", "could", "did", "do", "don't", "down", "up", "each", "few", "get", "got", "had", "have", "has", "he", "her", "she", "he", "it", "we", "they", "if", "thus", "it's", "hers", "his", "how", "why", "when", "where", "just", "like", "you", "me", "my", "most", "more", "no", "not", "yes", "off", "once", "only", "our", "out", "over", "under", "own", "then", "some", "these", "there", "then", "this", "those", "too", "through", "between", "until", "very", "who", "with", "wouldn't", "would", "was", "were", "itself", "himself", "herself", "which", "make", "during", "before", "after", "if", "any", "become", "around", "several", "them", "their", "however", "http", "https", "com", "co", "&", "-", "@", "rt", "+", "|", "so", "your", "i'm", "what", "new", "1", "2", "3", "4", "5", "6", "7", "8", "9", "0", "we're", "//", "it", "i've", "oh", "it.", "...", "&", "&amp;", "twitter", "tweets", "next", "let", "come", "i'll", "thing", "rt:", "things", "you're", "am", "well", "two", "one", "yet", "go", "going", "because", "every", "actually", "another", "we'll", "i'd", "something", "really", "he's", "much", "less", "us", "same", "him", "they're", "thanks", "great", "bad", "can't", "can", "say", "tell", "told", "here", "look", "little", "big", "saw", "awesome", "probably", "trying", "should", "never", "old", "largest", "best", "now", "good", "wait", "first" ]

  def initialize(pretendee)
     @pretendee = pretendee
     @client = client
  end

  def client
    Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV["twitter_key"]
      config.consumer_secret     = ENV["twitter_secret"]
      config.access_token        = ENV["twitter_access_token"]
      config.access_token_secret = ENV["twitter_access_token_secret"]
    end
  end

  def words
    frequency = Hash.new(0)
    insta_captions = self.instagram_text
    insta_captions.nil? ? (insta_captions = []) : insta_captions
    words = (favorites_text + all_tweets_text + all_descriptions_text + insta_captions).flatten.join(' ').gsub(/"/, '').gsub('.', '').gsub(':', '').gsub('!', '').gsub(')', '').gsub('(', '').gsub(",","").gsub('-', '').gsub("|", "").gsub("/'s", '').split(' ')
    words.each { |word| frequency[word.downcase] += 1 }
    frequency
  end

  def favorites_text
    favorites.map {|tweet| tweet.text}
  end

  def all_tweets_text
    get_all_tweets.map {|tweet| tweet.text}
  end

  def all_descriptions_text
    all_friends.collect {|t| t.description}
  end

  def word_count_histogram
    frequency = words
    frequency = frequency.reject {|word, count| COMMON_WORDS.include? word}
    frequency = frequency.map do |word, count| 
      {text: word, weight: count}
    end
    frequency.sort_by{|hash| hash[:weight]}.reverse[0..199]
  end

  def favorites
    @client.favorites(@pretendee.twitter).collect {|favorite| favorite}
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
    response = yield(max_id) if collection.length <= 1000
    collection += response if response
    response.nil? || response.empty? ? collection.flatten : collect_with_max_id(collection, response.last.id - 1, &block)
  end

  def all_friends
    friend_ids = all_friend_ids
    start = 0
    finish = 99
    friends = []
    while friends.flatten.length < friend_ids.length
      if start > friend_ids.length || start > 3000
        start = (friend_ids.length - 1)
      end
      if finish > friend_ids.length || finish > 3000
        finish = (friend_ids.length - 1)
      end
      options = friend_ids[start..finish]
      friends << @client.users(options)
      start += 100
      finish += 100
    end
    friends.flatten.compact.select {|d| d.description.class == String}
  end

  def all_friend_ids
    cursor = -1
    friend_ids = []
    while cursor < 0
      response = @client.friend_ids(@pretendee.twitter)
      friend_ids << response.attrs[:ids]
      cursor += 1
    end
    friend_ids.flatten
  end

  def popular_tweets(topic)
    tweets = @client.search("#" + topic.name.gsub(" ",""), result_type: "popular", lang: "en")
    tweets = tweets.sort_by {|tweet| tweet.retweet_count}.reverse
    tweets = tweets.uniq.map do |tweet| 
      {
        text: tweet.text,
        tweeter: tweet.user.name,
        date: tweet.created_at,
        url: tweet.uri.to_s,
        retweet_count: tweet.retweet_count,
        favorite_count: tweet.favorite_count,
        photo_url: (tweet.media.first.media_url.to_s if tweet.media.present?)
      }
    end.flatten
  end

  def recent_tweets
    options = {count: 10, include_rts: true}
    @client.user_timeline(@pretendee.twitter, options).map do |tweet|
      {
        url: tweet.uri.to_s,
        text: tweet.text,
        date: tweet.created_at.to_s.split.first,
        photo_url: (tweet.media[0].media_url.to_s if tweet.media.present?)
      }
    end.compact
  end

  def popular_tweets_with_links(hashtag)
    @client.search(hashtag, type: "popular").attrs.first[1].select do |tweet|
      puts tweet[:entities][:urls] 
    end
  end

  def has_instagram?
    tweets = get_all_tweets.select do |tweet|
      tweet.urls != [] && tweet.retweeted? == false
    end

    instagram_tweet = tweets.select do |tweet|
      tweet.urls[0].attrs[:expanded_url].include?("http://instagram.com/") || tweet.urls[0].attrs[:expanded_url].include?("https://instagram.com/") 
    end

    instagram_tweet.any?
  end

  def get_insta_tweet
    tweets = get_all_tweets.select do |tweet|
      tweet.urls != [] && tweet.retweeted? == false
    end

    instagram_tweet = tweets.select do |tweet|
      tweet.urls[0].attrs[:expanded_url].include?("http://instagram.com/") || tweet.urls[0].attrs[:expanded_url].include?("https://instagram.com/") 
    end.first

    if instagram_tweet != nil 
      instagram_tweet.urls[0].attrs[:expanded_url] if instagram_tweet.urls[0].attrs[:expanded_url] 
    end
  end

  def photo_id
    link = get_insta_tweet
    if (link && link.first(5) == "http:")
      link.gsub("http://instagram.com/p/", "").gsub("/", "")
    elsif (link && link.first(5) == "https:")
      link.gsub("https://instagram.com/p/", "").gsub("/", "")
    end
  end

  def instagram_text
    i = InstagramWrapper.new
    insta_id = i.get_id(self.photo_id)
    captions = nil
    if insta_id
      captions = i.instagram_caption_text(insta_id)
    end
    captions
  end

  def get_name
    @client.user(@pretendee.twitter).name
  end

end