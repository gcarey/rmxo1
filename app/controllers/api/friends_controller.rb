module Api
  class FriendsController < ApplicationController
		doorkeeper_for :all  
    protect_from_forgery with: :null_session
    respond_to :json

    def index
      @friends = current_user.friends
      @shares = Share.where(user_id: current_user.id).where(visited: nil)
    end
  end
end