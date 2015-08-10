namespace :emails do 

  task :send_report_emails_every_day => :environment do
    Report.every_day.each do |report|
      UserMailer.pretendee_report_email(report).deliver_now
    end
  end

  task :send_pretendee_report_emails_every_three_days => :environment do
    Report.every_three_days.each do |report|
      UserMailer.pretendee_report_email(report).deliver_now
    end
  end

  task :send_pretendee_report_emails_every_week => :environment do
    Report.every_week.each do |report|
      UserMailer.pretendee_report_email(report).deliver_now
    end
  end

end