class Location < ActiveRecord::Base
  reverse_geocoded_by :latitude, :longitude do |obj,results|
    if geo = results.first
      obj.street  = geo.street_address
      obj.city    = geo.city
      obj.zip     = geo.postal_code
      obj.country = geo.country_code
    end
  end

  validates :latitude, :longitude, :sign, presence: true
  after_validation :reverse_geocode

  mount_uploader :sign, SignUploader

  scope :not_locked, ->{ where(locked: false) }

  def full_address
    [street, zip, city, country].compact.reject(&:empty?).join(", ")
  end
end
