module Api
  class LocationsController < ApplicationController
    respond_to :json

    def index
      respond_with(Location.all)
    end

    def show
      respond_with(Location.find(params[:id]))
    end

    private

      # Never trust parameters from the scary internet, only allow the white list through.
      def location_params
        params.require(:location).permit(:street, :zip, :city, :country, :sign)
      end
  end
end
