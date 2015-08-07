namespace :emails do 

  task :send_report_emails => :environment do
    Report.active.each do |report|
      UserMailer.report_email(report).deliver_later
    end
  end

end