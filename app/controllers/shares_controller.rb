 class SharesController < ApplicationController

  def visit_link
    t = Tip.find(params[:id])
    s = t.shares.where(user_id: current_user.id)
    s.update_all(visited: true)
    redirect_to params[:link]
  end

  def destroy
    t = Tip.find(params[:id])
    s = t.shares.where(user_id: current_user.id).last
    s.delete
    redirect_to :back, notice: 'Tip removed.'
  end
end