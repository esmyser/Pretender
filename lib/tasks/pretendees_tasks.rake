namespace :pretendees do 

  task update_word_cloud: :environment do
    Pretendee.all.each do |pretendee|
      pretendee.update_word_cloud
    end
  end

  # need an update_word_cloud method that updates the word cloud and saves it to DB
  # will need to add word_cloud json to database
  # update controller to pass either the existing one if it exists or to create it if it doesn't
end