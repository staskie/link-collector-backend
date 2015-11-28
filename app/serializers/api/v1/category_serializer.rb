module Api
  module V1
    class CategorySerializer < ActiveModel::Serializer
      root false

      attributes :id, :name

      has_many :links, serializer: LinkSerializer
    end
  end
end
