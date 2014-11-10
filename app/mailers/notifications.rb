class Notifications < ActionMailer::Base
  default from: "notifications@tipster.to"

  def welcome(user)
    @user = user
    @url  = 'http://www.tipster.to/users/sign_in'
    @image = 'logo.png'
		attachments.inline['logo.png'] = File.read("#{Rails.root}/public/assets/#{@image}")
    mail(to: @user.email, subject: 'Tipster — Thanks for signing up!')
  end
end
