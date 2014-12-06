class PagesController < ApplicationController
  def front
  	render layout: "index"
  end

  def inbox
  	if params[:filter]
  		@filter = params[:filter]
  	end
  end

  def mobile_settings
  end
end
