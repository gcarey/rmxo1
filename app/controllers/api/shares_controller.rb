module Api
  class SharesController < ApplicationController
    doorkeeper_for :all  
    protect_from_forgery with: :null_session
    respond_to :json

    def serve_link
      @share = Share.find(params[:id])
      @share.update(served: true)
      render nothing: true
    end

    def visit_link
      @share = Share.find(params[:id])
      @share.update(visited: true)
      render nothing: true
    end
  end
end
