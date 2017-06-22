class NotificationSerializer < ActiveModel::Serializer
  attributes :id, :reason, :body, :action_id, :action_type, :read, :created_at

  has_one :from, serializer: SimpleUserSerializer
end
