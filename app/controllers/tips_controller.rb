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
    @tip = current_user.tips.build(tip_params)
    @tip.recipient_id = params[:recipient_id]

    #Check if the tip being saved is a reshare, add reshare to original tip
    if Tip.exists?(recipient_id: current_user, link: params[:tip][:link])
      @received_tip = Tip.where(recipient_id: current_user).where(link: params[:tip][:link]).last
      @received_tip.increment!("reshares", by = 1)
    end

    respond_to do |format|
      if @tip.valid? && @tip.save
        format.html { redirect_to root_url, notice: 'Tip was successfully created.' }
        format.json { render :show, status: :created, location: @tip }
      elsif !@tip.valid?
        format.html { redirect_to root_url, notice: "That doesn't seem to be a real URL. Did you include http:// at the beginning?" }
        format.json { render :show, status: :created, location: @tip }
      else
        format.html { render :new }
        format.json { render json: @tip.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tips/1
  # DELETE /tips/1.json
  def destroy
    @tip.destroy
    redirect_to :back, notice: 'Tip was successfully destroyed.'
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
