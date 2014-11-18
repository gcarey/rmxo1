class PagesController < ApplicationController
  def front
  	render layout: "index"
  end

  def inbox
  	@shares = Share.where(user_id: current_user.id).where(visited: nil)
  end
end
