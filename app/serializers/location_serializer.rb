class LocationSerializer < ActiveModel::Serializer
  attributes :id, :latitude, :longitude, :street, :zip, :city, :country, :full_address, :thumbnail, :picture, :created_at

  def thumbnail
    object.sign_url(:thumb)
  end

  def picture
    object.sign_url(width: 300, height: 300, crop: 'fill', secure: true)
  end

  def created_at
    I18n.l(object.created_at, format: :short)
  end
end
