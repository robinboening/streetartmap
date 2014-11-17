module Api
  class LocationsController < ApplicationController
    respond_to :json

    def index
      respond_with(Location.all)
    end

    def show
      respond_with(Location.find(params[:id]))
    end

    def create
      params.delete(:format)
      params[:sign] = params.delete(:file)
      binding.pry
      @location = Location.new(location_params)
      if @location.save
        head 200
      else
        head 400, status: :unprocessable_entity
      end
    end

    private

      # Never trust parameters from the scary internet, only allow the white list through.
      def location_params
        params.require(:location).permit(:latitude, :longitude, :sign)
      end
  end
end
