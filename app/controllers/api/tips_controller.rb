module Api
  class TipsController < Api::BaseController

    private

      def tip_params
        params.require(:link).require(:user_id).permit()
      end

      def query_params
        # this assumes that an album belongs to an artist and has an :artist_id
        # allowing us to filter by this
        params.permit(:user_id, :link)
      end

  end
end