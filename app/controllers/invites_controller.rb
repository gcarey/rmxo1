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

    respond_to do |format|
      if @invite.save
        render js: "$('"+params[:email]+"').html('Invite sent.').removeClass().addClass('added');"
      end
    end
  end
end
