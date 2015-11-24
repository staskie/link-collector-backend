module V1
  class LinkSerializer < ActiveModel::Serializer
    attributes :id, :url

    has_one :category, serializer: V1::CategorySerializer
    has_one :user, serializer: V1::UserSerializer
  end
end
