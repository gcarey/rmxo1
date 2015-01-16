class PagesController < ApplicationController
  before_action :authenticate_user!, except: [:front]

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
