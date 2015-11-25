module Api
  module V1
    class SessionsController < ApplicationController
      def destroy
        @current_user = nil

        response.headers['X-API-UUID']  = nil
        response.headers['X-API-TOKEN'] = nil

        render json: 'Session removed', status: :ok
      end
    end
  end
end
