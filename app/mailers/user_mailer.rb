class UserMailer < ActionMailer::Base
  default from: "buddy@cats.com"

  def welcome_email(user)
    @user = user
    @url = 'http://localhost:3000/session/new'
    mail(to: @user.user_name, subject: 'FOR CATS!')
  end


end
