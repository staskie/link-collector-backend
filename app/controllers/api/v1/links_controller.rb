module Api
  module V1
    class LinksController < BaseController
      def index
        render json: current_user_links, each_serializer: LinkSerializer
      end

      def create
        form = LinkForm.new(Link.new)

        if form.submit(link_params)
          render json: form.link, serializer: LinkSerializer,
                 status: :created
        else
          render json: { error: form.errors }, status: :unprocessable_entity
        end
      end

      def update
        form = LinkForm.new(Link.find(params[:id]))

        if form.submit(link_params)
          render json: form.link, serializer: LinkSerializer, status: :ok
        else
          render json: { error: form.errors }, status: :unprocessable_entity
        end
      end

      private

      def link_params
        params.require(:link).permit(:category_name, :url)
          .merge(user: current_user)
      end

      def current_user_links
        current_user.links.includes(:category).references(:categories)
      end
    end
  end
end
