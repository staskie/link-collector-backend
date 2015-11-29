module Api
  module V1
    class CategorySerializer < ActiveModel::Serializer
      root false

      attributes :id, :name
    end
  end
end
