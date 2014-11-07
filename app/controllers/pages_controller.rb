class PagesController < ApplicationController
  def front
  	render layout: "index"
  end

  def api_login
  	render layout: "index"
  end

  def inbox
  end
end
