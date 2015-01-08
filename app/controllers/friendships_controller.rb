class FriendshipsController < ApplicationController

  # POST /friendships
  # POST /friendships.json
  def create
    @friendship = current_user.friendships.build(:friend_id => params[:friend_id], approved: params[:og])
    @recipient = User.find(params[:friend_id])

    if @friendship.save && params[:omnicontact]
      render js: "document.getElementById('"+params[:email]+"').innerHTML = 'Friend requested.'; document.getElementById('"+params[:email]+"').className = 'added';"
    elsif @friendship.save && params[:og]
      flash[:notice] = "Garrett has now been added as your friend."
      redirect_to :back
    elsif @friendship.save
      flash[:notice] = "Friend requested."
      redirect_to :back
    else
      flash[:error] = "Unable to request friendship."
      redirect_to :back
    end

    if @friendship.save
      Notifications.friend_request(@recipient, current_user).deliver if @recipient.settings(:email).friend == true
    end
  end

  # PATCH/PUT /friendships/1
  # PATCH/PUT /friendships/1.json
  def update
  @friendship = Friendship.where(friend_id: current_user, user_id: params[:id]).first
  @friendship.update(approved: params[:approved])
    if @friendship.save && params[:approved] == "true"
      render js: "$('#f-"+params[:id]+"').children('.request').remove(); $('#f-"+params[:id]+"').append('<p>Friend added.<p>'); $('.friend-alert').remove();"
    elsif @friendship.save && params[:approved] == "false"
      render js: "$('#f-"+params[:id]+"').children('.request').remove(); $('#f-"+params[:id]+"').append('<p>Request declined.<p>'); $('.friend-alert').remove();"
    end
  end

  # DELETE /friendships/1
  # DELETE /friendships/1.json
  def destroy
    @friendship = Friendship.where(friend_id: [current_user, params[:id]]).where(user_id: [current_user, params[:id]]).last
    @friendship.destroy
    flash[:notice] = "We never liked them anyway."
    redirect_to :back
  end
end
