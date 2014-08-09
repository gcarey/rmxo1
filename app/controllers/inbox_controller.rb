class InboxController < ApplicationController

  # GET /tips
  # GET /tips.json
  def index
    @tips = Tip.where(recipient_id: current_user).all
  end
end
