class FriendshipsController < ApplicationController

  # POST /friendships
  # POST /friendships.json
  def create
    @friendship = current_user.friendships.build(:friend_id => params[:friend_id], approved: "false")
    if @friendship.save && params[:omnicontact]
      redirect_to "/contacts/gmail", :notice => "Friend requested."
    elsif @friendship.save
      redirect_to :back, :notice => "Friend requested."
    else
      redirect_to :back, :error => "Unable to request friendship."
    end
  end

  # PATCH/PUT /friendships/1
  # PATCH/PUT /friendships/1.json
  def update
  @friendship = Friendship.where(friend_id: current_user, user_id: params[:id]).first
  @friendship.update(approved: true)
    if @friendship.save
      redirect_to root_url, :notice => "Successfully confirmed friend!"
    else
      redirect_to root_url, :notice => "Sorry! Could not confirm friend!"
    end
  end

  # DELETE /friendships/1
  # DELETE /friendships/1.json
  def destroy
    @friendship = Friendship.where(friend_id: [current_user, params[:id]]).where(user_id: [current_user, params[:id]]).last
    @friendship.destroy
    flash[:notice] = "Removed friendship."
    redirect_to :back
  end
end
