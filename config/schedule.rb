set :environment, "development"

every 1.minute, :at => '12:00 am' do
  rake "emails:send_report_emails"
end