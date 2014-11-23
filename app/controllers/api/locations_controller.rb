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
      params['location'] = {} unless params['location']
      params['location'] = JSON.parse params['location']
      params['location']['sign'] = params.delete 'sign'
      @location = Location.new(location_params)
      if @location.save
        head :created, location: @location
      else
        head 400, status: :unprocessable_entity, errors: @location.errors.full_messages.join("<br>")
      end
    end

    private

      # Never trust parameters from the scary internet, only allow the white list through.
      def location_params
        params.require(:location).permit(:latitude, :longitude, :sign)
      end
  end
end
