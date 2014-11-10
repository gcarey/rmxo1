class Notifications < ActionMailer::Base
  default from: "notifications@tipster.to"

  def welcome(user)
    @user = user
    @url  = 'http://www.tipster.to/users/sign_in'
		attachments.inline['logo.png'] = File.read('/app/assets/images/logo.png')
    mail(to: @user.email, subject: 'Tipster — Thanks for signing up!')
  end
end
