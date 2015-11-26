module Api
  module V1
    class LinkSerializer < ActiveModel::Serializer
      attributes :id, :url

      has_one :category, serializer: V1::CategorySerializer
    end
  end
end
