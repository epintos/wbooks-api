class UserSerializer < SimpleUserSerializer
  attributes :rents_counter, :comments_counter, :unread_notifications_count
end
