class PagesController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
  	render layout: "front"
  end

  def inbox
  	if params[:filter]
  		@filter = params[:filter]
  	end
  end

  def mobile_settings
  end

  def tour
    render layout: "welcome"
  end
end
