class UserMailer < ApplicationMailer

  def report_email(report)
    @report = report
    @pretendee = Pretendee.find(@report.pretendee_id)
    @user = User.find(@pretendee.user_id)
    @url = 'http://pretender.io'
    mail(to: @user.email, subject: "Your report from pretender.io")
  end

# From Rose
  # def initial_schedule_notification(schedule, user)
  #   @schedule = schedule
  #   @user = user
  #   @blog_assignments = @user.blog_assignments.where(schedule_id: @schedule.id)

  #   mail(to: @user.email, subject: "Your Blog Assignments for #{@schedule.name}")
  # end

  # def reminder_email(blog_assignment)
  #   @blog_assignment = blog_assignment
  #   @user = blog_assignment.user

  #   mail(to: @user.email, subject: "Blog post due tomorrow #{@blog_assignment.due_date.strftime("%m/%d")}")
  # end

end
