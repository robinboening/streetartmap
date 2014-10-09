json.array!(@locations) do |location|
  json.extract! location, :id, :lat, :long, :city_id, :cached_city, :country_id, :cashed_country
  json.url location_url(location, format: :json)
end
