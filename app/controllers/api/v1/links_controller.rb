module Api
  module V1
    class LinksController < ApplicationController

      def index
        render json: current_user.links, each_serializer: ::V1::LinkSerializer
      end

      def create
        link = Link.new(link_params)

        if link.save
          render json: link, serializer: ::V1::LinkSerializer, status: :created
        else
          render json: { error: 'Could not create a link'},
            status: :unprocessable_entity
        end
      end

      private

      def link_params
        params.require(:link).permit(:category_id, :url).merge(user: current_user)
      end
    end
  end
end
