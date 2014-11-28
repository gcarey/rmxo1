class AjaxController < ApplicationController
  def settings
  	@tab = params[:tab]
  	
  	respond_to do |format|
	    format.html { redirect_to root_path }
	    format.js
	  end
  end

  def set_notification
  	@type = params[:type]
  	if params[:setting] == 'true'
  		current_user.settings(:email).update_attributes! @type => true
  	elsif params[:setting] == 'false'
  		current_user.settings(:email).update_attributes! @type => false
  	end
  	render nothing: true
  end
end
