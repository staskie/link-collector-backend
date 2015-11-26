module Api
  module V1
    class CategoriesController < BaseController
      def index
        render json: UserCategoriesQuery.call(current_user),
               each_serializer: CategorySerializer
      end

      def create
        category = Category.new(category_params)

        if category.save
          render json: category,
                 serializer: CategorySerializer,
                 status: :created
        else
          render json: { error: 'Could not create a category' },
                 status: :unprocessable_entity
        end
      end
    end
  end
end
