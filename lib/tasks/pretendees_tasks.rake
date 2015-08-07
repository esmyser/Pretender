namespace :pretendees do 

  task update_word_cloud: :environment do
    Pretendee.all.each do |pretendee|
      pretendee.update_word_cloud
    end
  end

  # need an update_word_cloud method that updates the word cloud and saves it to DB
end