namespace :topics do 

  task update_topics: :environment do
    Topic.all.each do |topic|
      topic.get_word_histogram
      topic.get_recent_tweets
      topic.get_recent_instagrams
      sleep(300)
    end
  end
end