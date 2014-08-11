class InboxController < ApplicationController

  # GET /tips
  # GET /tips.json
  def index
    @tips = Tip.where(recipient_id: current_user).all.order("created_at DESC")
    render "pages/inbox"
  end
end