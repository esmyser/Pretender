namespace :emails do 

  task :send_reports => :environment do 
    Report.active.each do |email|
      UserMailer.welcome
    end
  end


end