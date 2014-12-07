class InvitesController < ApplicationController

  # POST /invites
  # POST /invites.json
  def create
    if Invitee.where(email: params[:email]).last
      @invitee = Invitee.where(email: params[:email]).last
    else
      @invitee = Invitee.create(email: params[:email])
    end

    @invite = current_user.invites.build(:invitee_id => @invitee.id)
    Notifications.invite(@invitee, current_user).deliver

    if @invite.save
      render js: "$('#"+params[:email]+"').html('Invite sent.').removeClass().addClass('added');"
      # render js: "document.getElementById('"+params[:email]+"').innerHTML = 'Friend requested.'; document.getElementById('"+params[:email]+"').className = 'added';"
    end
  end
end
