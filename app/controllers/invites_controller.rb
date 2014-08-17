class InvitesController < ApplicationController

  # GET /tips
  # GET /tips.json
  def callback
	  @contacts = request.env['omnicontacts.contacts']
	  @user = request.env['omnicontacts.user']
  end
end