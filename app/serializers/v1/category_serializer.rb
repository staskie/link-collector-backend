module V1
  class CategorySerializer < ActiveModel::Serializer
    attributes :id, :name, :links
  end
end
