class Notifications < ActionMailer::Base
  default from: "notifications@tipster.to"

  def welcome(user)
    @user = user
		attachments.inline['logo.png'] = File.read('app/assets/images/logo.png')
		attachments.inline['header.jpg'] = File.read('app/assets/images/welcome-header.jpg')
    mail(to: @user.email, subject: 'Tipster — Thanks for signing up!')
  end

  def tip(user, share, sender)
    @user = user
    @share  = share
    @sender  = sender
		attachments.inline['logo.png'] = File.read('app/assets/images/logo.png')
		attachments.inline['header.jpg'] = File.read('app/assets/images/welcome-header.jpg')
    mail(to: @user.email, subject: 'You have a new tip!')
  end
end
