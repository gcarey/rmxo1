class UsersController < ApplicationController
  before_action :authenticate_user!

	def show
		# Figure out own profile page if ID is passed in by URL or no; used to set profile as authenticated root
    if params[:id]
    	@user = User.find(params[:id])
		else
  		# Show the currently logged in user
  		@user = current_user
		end
		is_friend
		new_tip
		discoveries
	end

  # Stopgap for Alpha
  def update_password
    @user = User.find(current_user.id)
    if @user.update(user_params)
      # Sign in the user by passing validation in case their password changed
      sign_in @user, :bypass => true
      redirect_to root_path, :notice => "Successfully changed password."
    else
      render "edit", :notice => "That didn't seem to work."
    end
  end


	private
  # Check if @user is current_user's friend
  def is_friend
  	@friendship = Friendship.where(friend_id: [current_user, params[:id]]).where(user_id: [current_user, params[:id]]).where(approved: true).last
    @requested_friendship = Friendship.where(friend_id: params[:id]).where(user_id: current_user).where(approved: nil).last
  end

	# Create new tip from profile
	def new_tip
  	@tip = current_user.tips.build
  end

  def discoveries
  	@discoveries = @user.originated_tips.where(user_id: @user)
  end

  # Stopgap for Alpha
  def user_params
    # NOTE: Using `strong_parameters` gem
    params.required(:user).permit(:password)
  end
end