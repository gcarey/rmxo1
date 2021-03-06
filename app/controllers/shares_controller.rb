 class SharesController < ApplicationController

  def visit_link
    tip = Tip.find(params[:id])
    # redirect_to "http://redirect.viglink.com?key=2936e5116a8b6c8d103ef904f2da99fd&u="+CGI.escape(tip.link)
    redirect_to tip.link
    if params[:invitee]
      shares = tip.outgoing_shares.where(invitee_id: params[:invitee])
    elsif params[:recipient]
      shares = tip.shares.where(user_id: params[:recipient])
    else
      shares = tip.shares.where(user_id: current_user.id)
    end
    shares.update_all(visited: true)
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