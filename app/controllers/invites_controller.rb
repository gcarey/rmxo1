class InvitesController < ApplicationController

  # GET /tips
  # GET /tips.json
  def callback
	  @contacts = request.env['omnicontacts.contacts']
	  @user = current_user
  end
end