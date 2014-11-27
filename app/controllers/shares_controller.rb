 class SharesController < ApplicationController

  def visit_link
    tip = Tip.find(params[:id])
    shares = tip.shares.where(user_id: current_user.id)
    shares.update_all(visited: true)
    redirect_to tip.link
  end

  def destroy
    tip = Tip.find(params[:id])
    shares = tip.shares.where(user_id: current_user.id)
    if shares.count > 0
      shares.delete_all
      redirect_to :back, notice: 'Tip removed.'
    else
      redirect_to root_path, notice: "That tip was sent to someone else."
    end
  end
end