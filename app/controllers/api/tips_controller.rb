module Api
  class TipsController < ApplicationController
    doorkeeper_for :all  
    protect_from_forgery with: :null_session
    before_action :set_resource, only: [:destroy, :show, :update]
    respond_to :json

    # POST /api/{plural_resource_name}
    def create
      @tip = Tip.new(tip_params)

      if @tip.save
        render :show, status: :created
      else
        render json: @tip.errors, status: :unprocessable_entity
      end
    end


    private

      def tip_params
        params.require(:tip).permit(:link, :user_id)
      end
  end
end