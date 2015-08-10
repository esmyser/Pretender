namespace :emails do 

  task :send_pretendee_report_emails_every_day => :environment do
    Report.every_day_pretendee.each do |report|
      UserMailer.pretendee_report_email(report).deliver_now
    end
  end

  task :send_pretendee_report_emails_every_three_days => :environment do
    Report.every_three_days_pretendee.each do |report|
      UserMailer.pretendee_report_email(report).deliver_now
    end
  end

  task :send_pretendee_report_emails_every_week => :environment do
    Report.every_week_pretendee.each do |report|
      UserMailer.pretendee_report_email(report).deliver_now
    end
  end

  task :send_topic_report_emails_every_day => :environment do
    Report.every_day_topic.each do |report|
      UserMailer.topic_report_email(report).deliver_now
    end
  end

  task :send_topic_report_emails_every_three_days => :environment do
    Report.every_three_days_topic.each do |report|
      UserMailer.topic_report_email(report).deliver_now
    end
  end

  task :send_topic_report_emails_every_week => :environment do
    Report.every_week_topic.each do |report|
      UserMailer.topic_report_email(report).deliver_now
    end
  end

end