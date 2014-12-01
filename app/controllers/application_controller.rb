class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?
  before_action :set_tip_badge

  def after_sign_in_path_for(resource)
  	if request.referer == 'http://www.tipster.to/api_login'
			'https://blnjggbjcgdainjapkkngieogamdhlkp.chromiumapp.org/oce'
  	else
    	stored_location_for(resource) || root_path
    end
  end

  private
    def set_tip_badge
      if current_user
        @newtips = Share.where(user_id: current_user.id).where(visited: nil)
      end
    end

	protected
	 def configure_permitted_parameters
	   devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:first_name, :last_name, :email, :password, :provider, :uid) }
     devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:first_name, :last_name, :email, :password, :current_password, :avatar, :provider, :uid) }
	 end
end
