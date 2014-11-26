class PopupsController < ApplicationController
  def api_login
  	render layout: "popup"
  end

  def settings
  	respond_to do |format|
	    format.html { redirect_to root_path }
	    format.js
	  end
  end
end
