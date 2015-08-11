namespace :pretendees do 

  task update_pretendees: :environment do
    Pretendee.all.each do |pretendee|
      pretendee.get_word_histogram
      pretendee.get_recent_tweets
      pretendee.get_recent_instagrams
      sleep(300)
    end
  end
end