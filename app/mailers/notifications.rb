class Notifications < ActionMailer::Base
  default from: '"Tipster" <notifications@tipster.to>'
  before_action :set_logo

  def welcome(user)
    @user = user
		attachments.inline['header.jpg'] = File.read('app/assets/images/welcome-header.jpg')
    mail(to: @user.email, subject: 'Tipster — Thanks for signing up!')
  end

  def tip(recipient, sender, tip)
    @recipient = recipient
    @sender  = sender
    @tip  = tip
		attachments.inline['header.jpg'] = File.read('app/assets/images/tip-header.jpg')
    mail(to: @recipient.email, subject: 'New tip from '+@sender.first_name+': '+@tip.title, reply_to: @sender.email)
  end

  def outgoing_tip(recipient, sender, tip)
    @recipient = recipient
    @sender  = sender
    @tip  = tip
    attachments.inline['header.jpg'] = File.read('app/assets/images/tip-header.jpg')
    mail(to: @recipient.email, subject: 'Message from '+@sender.first_name+' on Tipster', reply_to: @sender.email)
  end

  def friend_request(recipient, sender)
    @recipient  = recipient
    @sender  = sender
    attachments.inline['header.jpg'] = File.read('app/assets/images/friend-header.jpg')
    mail(to: @recipient.email, subject: 'You have a friend request!')
  end

  def invite(recipient, sender)
    @recipient  = recipient
    @sender  = sender
    attachments.inline['header.jpg'] = File.read('app/assets/images/invite-header.jpg')
    mail(to: @recipient.email, subject: @sender.full_name+' wants you to join Tipster!')
  end

  private
    def set_logo
      attachments.inline['logo.png'] = File.read('app/assets/images/logo.png')
    end
end
