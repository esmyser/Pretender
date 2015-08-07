set :environment, "development"

every 1.day, :at => '6:00 am' do
  rake "emails:send_report_emails_every_day"
end

every 3.days, :at => '6:00 am' do
  rake "emails:send_report_emails_every_three_days"
end

every 7.days, :at => '6:00 am' do
  rake "emails:send_report_emails_every_week"
end