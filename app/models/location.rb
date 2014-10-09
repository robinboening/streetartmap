class Location < ActiveRecord::Base
  geocoded_by :full_address
  validate :city, :country, presence: true
  after_validation :geocode

  mount_uploader :sign, SignUploader

  def full_address
    [street, zip, city, country].reject(&:empty?).join(", ")
  end

  # def self.default
  #   Geocoder.coordinates("Berlin, Germany")
  # end
end
