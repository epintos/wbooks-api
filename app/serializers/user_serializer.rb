class UserSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :email, :rents_counter, :comments_counter, :image_url, :unreaded_notifications_count
end
