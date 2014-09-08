class InboxController < ApplicationController

  # GET /tips
  # GET /tips.json
  def index
    render "pages/inbox"
  end
end