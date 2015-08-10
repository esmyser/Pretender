set :environment, "development"

every 1.day, :at => '3:40 pm' do
  rake "emails:send_pretendee_report_emails_every_day"
  rake "emails:send_topic_report_emails_every_day"
end

every 3.days, :at => '3:40 pm' do
  rake "emails:send_pretendee_report_emails_every_three_days"
  rake "emails:send_topic_report_emails_every_three_days"
end

every 7.days, :at => '3:40 pm' do
  rake "emails:send_pretendee_report_emails_every_week"
  rake "emails:send_topic_report_emails_every_week"
end