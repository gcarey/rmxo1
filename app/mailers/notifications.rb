class Notifications < ActionMailer::Base
  default from: '"Tipster" <notifications@tipster.to>'

  def welcome(user)
    @user = user
		attachments.inline['logo.png'] = File.read('app/assets/images/logo.png')
		attachments.inline['header.jpg'] = File.read('app/assets/images/welcome-header.jpg')
    mail(to: @user.email, subject: 'Tipster — Thanks for signing up!')
  end

  def tip(recipient, tip, sender)
    @recipient = recipient
    @tip  = tip
    @sender  = sender
		attachments.inline['logo.png'] = File.read('app/assets/images/logo.png')
		attachments.inline['header.jpg'] = File.read('app/assets/images/tip-header.jpg')
    mail(to: @recipient.email, subject: 'You have a new tip!')
  end

  def friend_request(recipient, sender)
    @recipient  = recipient
    @sender  = sender
    attachments.inline['logo.png'] = File.read('app/assets/images/logo.png')
    attachments.inline['header.jpg'] = File.read('app/assets/images/tip-header.jpg')
    mail(to: @recipient.email, subject: 'You have a friend request!')
  end
end
