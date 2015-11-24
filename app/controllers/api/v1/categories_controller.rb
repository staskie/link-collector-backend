module Api
  module V1
    class CategoriesController < ApplicationController
      def index
        render json: UserCategoriesQuery.call(current_user),
          each_serializer: ::V1::CategorySerializer
      end
    end
  end
end
