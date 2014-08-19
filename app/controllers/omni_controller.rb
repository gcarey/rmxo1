class OmniController < ApplicationController
  layout "omni"

  # GET /tips
  # GET /tips.json
  def findfriends
	  @contacts = request.env['omnicontacts.contacts']
	  @user = current_user
  end
end