class NotificationSerializer < ActiveModel::Serializer
  attributes :id, :reason, :from, :information, :action_id, :action_type, :read, :created_at
end
