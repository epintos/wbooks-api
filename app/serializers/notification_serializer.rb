class NotificationSerializer < ActiveModel::Serializer
  attributes :id, :type, :user_from, :information, :action_id, :action_type, :read, :created_at
end
