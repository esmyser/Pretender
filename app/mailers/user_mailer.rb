class UserMailer < ApplicationMailer

  def welcome_email(user)
    @user = user
    @url = 'http://pretender.io'
    mail(to: @user.email, subject: "Thanks for signing up, #{@user.name}!")
  end

  def report_email(report)
    @report = report
    @pretendee = Pretendee.find(@report.pretendee_id)
    @user = User.find(@pretendee.user_id)
    @url = 'http://pretender.io'
    @email_with_name = %("#{@user.name}" <#{@user.email}>)
    mail(to: @email_with_name, subject: "Your report from pretender.io")
  end

end
