class UsersController < ApplicationController
  before_action :authenticate_user!

	def show
    if params[:id]
    	@user = User.find(params[:id])
		else
  		# Show the currently logged in user
  		@user = current_user
		end
	end
end