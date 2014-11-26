class LocationSerializer < ActiveModel::Serializer
  attributes :id, :latitude, :longitude, :street, :zip, :city, :country, :full_address, :thumbnail, :picture, :locked, :created_at

  def thumbnail
    return if locked
    object.sign_url(:thumb)
  end

  def picture
    return if locked
    object.sign_url(width: 300, height: 300, crop: 'fill', secure: true)
  end

  def created_at
    I18n.l(object.created_at, format: :short)
  end
end
