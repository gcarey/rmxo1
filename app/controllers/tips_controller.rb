class TipsController < ApplicationController
  before_action :set_tip, only: [:show, :edit, :update, :destroy]

  # GET /tips
  # GET /tips.json
  def index
    if params[:user_id] 
      @tips = Tip.where(user_id: params[:user_id]).all
    elsif params[:recipient_id] 
      @tips = Tip.where(recipient_id: params[:recipient_id]).all
    else 
      @tips = Tip.all
    end
  end

  # POST /tips
  # POST /tips.json
  def create
    @tip = current_user.tips.build(tip_params)
    @tip.recipient_id = params[:recipient_id]

    respond_to do |format|
      if @tip.save
        format.html { redirect_to root_url, notice: 'Tip was successfully created.' }
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
    redirect_to tips_url, notice: 'Tip was successfully destroyed.'
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
