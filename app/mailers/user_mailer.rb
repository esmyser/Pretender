class UserMailer < ApplicationMailer

  def welcome(user)
    @user = user
    @url = 'http://pretender.io'
    mail(to: @user.email, subject: "you're a creepster--and so is ezra")
  end

  # def digest(user, pretendee)
  #   @user = user
  #   @pretendee = pretendee
  #   @url = 'http://pretender.io'
  #   mail(to: @user.email, subject: "you're stalker digest for #{pretendee.name}")
  # end
end
