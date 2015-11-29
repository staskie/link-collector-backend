module Api
  module V1
    class CategoryLinksController < BaseController

      def index
        render json: category_links, each_serializer: LinkSerializer
      end

      private

      def category_links
        Link.where(user: current_user, category_id: params[:category_id])
      end
    end
  end
end
