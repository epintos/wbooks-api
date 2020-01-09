class BookWithRentSerializer < ActiveModel::Serializer
  attributes :id, :author, :title, :genre, :publisher, :year, :id, :image_url, :actual_rent

  def actual_rent
    last_rent = object.rents.last
    return unless last_rent.present?
    return unless last_rent.in_progress

    RentSimpleSerializer.new(last_rent).as_json
  end
end
