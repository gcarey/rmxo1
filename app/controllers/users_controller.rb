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
		user_tips
    friend_list
	end

	def create
	  @user = User.create(user_params)
	end


	private
  # Check if @user is current_user's friend
  def is_friend
  	@friendship = Friendship.where(friend_id: [current_user, params[:id]]).where(user_id: [current_user, params[:id]]).last
  end

	# Create new tip from profile
	def new_tip
  	@tip = current_user.tips.build
  end

  # List tips sent by a user on his profile
  def user_tips
  	@tips = Tip.where(user_id: @user).all.order("created_at DESC")
  end

  def friend_list
    @friends = User.find_by_sql("SELECT users.*, 
    COUNT(tips.id) AS c FROM users, tips 
    WHERE tips.recipient_id = users.id 
    AND tips.user_id = 3
    GROUP BY users.id ORDER BY c DESC")
  end
end