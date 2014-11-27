class AjaxController < ApplicationController
  def settings
  	@tab = params[:tab]
  	
  	respond_to do |format|
	    format.html { redirect_to root_path }
	    format.js
	  end
  end
end
