 class SharesController < ApplicationController

  def visit_link
    tip = Tip.find(params[:id])
    shares = tip.shares.where(user_id: current_user.id)
    shares.update_all(visited: true)
    redirect_to "http://api.viglink.com/api/click?out="+CGI.escape(tip.link)+"&loc="+CGI.escape(params[:loc])+"&key=2936e5116a8b6c8d103ef904f2da99fd&cuid="+params[:uid]+"&format=go"
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