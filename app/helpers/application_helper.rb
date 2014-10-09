module ApplicationHelper
  # def render_map(locations=[])
  #   map(
  #     center: {
  #       latlng: current_location || Location.default,
  #       zoom: 12
  #     },
  #     markers: locations.map { |l| {latlng: [l.latitude, l.longitude], popup: render(partial: 'map/popup', locals: {location: l}) } }
  #   )
  # end

  def current_location
    lat = request.location.try :latitude
    long = request.location.try :longitude
    if lat == 0 && long == 0
      return nil
    else
      [lat, long]
    end
  end

  def initial_location
    current_location || Location.default
  end
end
