class UserSerializer < ActiveModel::Serializer
  attributes :id, :first_name, :last_name, :email, :rents_counter, :comments_counter
end
