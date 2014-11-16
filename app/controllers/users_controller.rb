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
    @shares = Share.where(user_id: current_user.id).where(visited: nil)
		is_friend
		new_tip
		discoveries
	end


	private
  # Check if @user is current_user's friend
  def is_friend
  	@friendship = Friendship.where(friend_id: [current_user, params[:id]]).where(user_id: [current_user, params[:id]]).where(approved: true).last
    @requested_friendship = Friendship.where(friend_id: params[:id]).where(user_id: current_user).where(approved: false).last
  end

	# Create new tip from profile
	def new_tip
  	@tip = current_user.tips.build
  end

  def discoveries
  	@discoveries = @user.originated_tips.where(user_id: @user)
  end
end