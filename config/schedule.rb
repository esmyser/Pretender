set :environment, "development"

every 1.day, :at => '12:00 am' do
  rake "emails:send_report_emails"
end