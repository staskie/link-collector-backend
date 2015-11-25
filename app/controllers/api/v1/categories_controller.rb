module Api
  module V1
    class CategoriesController < ApplicationController
      def index
        render json: UserCategoriesQuery.call(current_user),
               each_serializer: ::V1::CategorySerializer
      end

      def create
        category = Category.new(category_params)

        if category.save
          render json: category,
                 serializer: ::V1::CategorySerializer,
                 status: :created
        else
          render json: { error: 'Could not create a category' },
                 status: :unprocessable_entity
        end
      end
    end
  end
end
