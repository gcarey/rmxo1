module Api
  class TipsController < ApplicationController
    doorkeeper_for :all  
    protect_from_forgery with: :null_session
    respond_to :json

    # GET /tips
    # GET /tips.json
    def index
      if current_user
        @unserved_shares = Share.where(user_id: current_user.id).where(visited: nil).where(served: nil)
        @newtips_count = Share.where(user_id: current_user.id).where(visited: nil).count
      end
    end

    # POST /api/tips
    def create
      if Tip.exists?(user_id: params[:user_id], link: params[:link])
        @tip = Tip.where(user_id: params[:user_id]).where(link: params[:link]).last
      else
        @tip = Tip.new(tip_params)
      end

      @user = User.find(params[:user_id])

      if params[:recipient_ids]
        @recipients = User.find(params[:recipient_ids].split(','))
        @tip.recipients << @recipients 
      end

      if params[:emails]
        @invitees = params[:emails].split(',')
        @invitees.each do |i|
          if Invitee.where(email: i).last
            @invitee = Invitee.where(email: i).last
          else
            @invitee = Invitee.create(email: i)
          end

          @received_tip.external_recipients << @invitee
          Notifications.outgoing_tip(@invitee, @user, @tip).deliver
        end
      end

      #Check if the tip being saved is a reshare
      if @user.received_tips.where(link: params[:tip][:link]).last != nil
        @user.received_tips.where(link: params[:tip][:link]).each do |t|
          #Add reshare to original tip
          t.increment!("reshares", by = @recipients.count)
        end
        #Record origin
        @original_tip = @user.received_tips.where(link: params[:tip][:link]).first
        @tip.originator_id = @original_tip.user_id
      else
        @tip.originator_id = params[:user_id]
      end

      if @tip.save
        render :show, status: :created
        @recipients.each do |r|
          Notifications.tip(r, @user, @tip).deliver if r.settings(:email).tip == true
        end
      else
        render json: @tip.errors, status: :unprocessable_entity
      end
    end



    private
      def tip_params
        params.require(:tip).permit(:link, :user_id)
      end
  end
end