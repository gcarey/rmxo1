class TipsController < ApplicationController
  before_action :set_tip, only: [:show, :edit, :update, :destroy]

  # GET /tips
  # GET /tips.json
  def index
    @tips = Tip.all
  end

  # POST /tips
  # POST /tips.json
  def create
    if Tip.exists?(user_id: current_user, link: params[:tip][:link])
      @tip = Tip.where(user_id: current_user).where(link: params[:tip][:link]).last
    else
      @tip = current_user.tips.build(tip_params)
    end
    @received_tip = @tip
    @recipient = User.find(params[:recipient_id])
    @received_tip.recipients << @recipient

    #Check if the tip being saved is a reshare
    if current_user.received_tips.where(link: params[:tip][:link]).last != nil
      current_user.received_tips.where(link: params[:tip][:link]).each do |t|
        #Add reshare to original tip
        t.increment!("reshares", by = 1)
      end
      #Record origin
      @original_tip = current_user.received_tips.where(link: params[:tip][:link]).first
      @tip.originator_id = @original_tip.user_id
    else
      @tip.originator_id = current_user.id
    end

    respond_to do |format|
      if @tip.valid? && @tip.save
        Notifications.tip(@recipient, @tip, current_user).deliver
        format.html { redirect_to root_url, notice: 'Tip sent!' }
      elsif !@tip.valid?
        format.html { redirect_to root_url, notice: "That doesn't seem to be a real URL. Did you include http:// at the beginning?" }
      else
        format.html { render :new }
      end
    end
  end

  # DELETE /tips/1
  # DELETE /tips/1.json
  def destroy
    @tip.destroy
    redirect_to :back, notice: 'That tip will never hurt you again.'
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tip
      @tip = Tip.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tip_params
      params.require(:tip).permit(:link)
    end
end
