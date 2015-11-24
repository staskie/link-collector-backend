module Api
  module V1
    class HomeController < ApplicationController
      before_filter :authenticate, except: [:index]

      def index
        render json: { status: 'OK' }, status: :ok
      end
    end
  end
end
