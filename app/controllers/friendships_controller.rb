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
  @friendship.update(approved: true)
    if @friendship.save && params[:response] == "accept"
      render js: "$('#f-"+params[:id]+"').children('.request').remove(); $('#f-"+params[:id]+"').append('<p>Friend added.<p>'); $('.friend-alert').remove();"
    elsif @friendship.save
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
    if params[:response] == "decline"
      render js: "$('#f-"+params[:id]+"').children('.request').remove(); $('#f-"+params[:id]+"').append('<p>Request declined.<p>'); $('.friend-alert').remove();"
    else
      flash[:notice] = "We never liked them anyway."
      redirect_to :back
    end
  end
end
