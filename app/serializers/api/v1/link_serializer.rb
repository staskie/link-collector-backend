module Api
  module V1
    class LinkSerializer < ActiveModel::Serializer
      root false

      attributes :id, :url, :category_name

      def category_name
        object.category_name
      end
    end
  end
end
