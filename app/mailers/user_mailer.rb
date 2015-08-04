class UserMailer < ApplicationMailer

  def welcome(user)
    @user = user
    @url = 'http://pretender.io'
    mail(to: @user.email, subject: "you're a creepster--and so is ezra")
    ### make sure to include deliver_now at the end of the method call to send it now.
  end

  # def digest(user, pretendee)
  #   @user = user
  #   @pretendee = pretendee
  #   @url = 'http://pretender.io'
  #   mail(to: @user.email, subject: "you're stalker digest for #{pretendee.name}")
  # end
end
