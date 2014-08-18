class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
      # You need to implement the method below in your model (e.g. app/models/user.rb)
      @user = User.find_for_google_oauth2(request.env["omniauth.auth"], current_user)

      if @user.persisted?
        flash[:notice] = I18n.t "devise.omniauth_callbacks.success", :kind => "Google"
        sign_in @user, :event => :authentication
        @after_sign_in_url = after_sign_in_path_for(user)
        render 'pages/callback', :layout => false
      else
        session["devise.google_data"] = request.env["omniauth.auth"]
        flash.notice = "Dang it! Something went wrong."
        redirect_to new_user_registration_url
      end
  end
end