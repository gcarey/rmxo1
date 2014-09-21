module Api
  class FriendsController < ApplicationController
    protect_from_forgery with: :null_session
    respond_to :json

    def index
      u=User.find(6)
      @friends=u.friends
    end
  end
end