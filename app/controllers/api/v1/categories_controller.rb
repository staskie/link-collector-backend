module Api
  module V1
    class CategoriesController < BaseController
      def index
        render json: UserCategoriesQuery.call(current_user),
               each_serializer: CategorySerializer
      end
    end
  end
end
