module Api
  module V1
    class SessionsController < BaseController

      skip_before_filter :authenticate, only: [:create]

      def create
        user = AuthenticateUser.call(params[:email], params[:password])

        if user
          render json: SessionSerializer.new(user, root: false).to_json,
                 status: :ok
        else
          authentication_error
        end
      end
    end
  end
end
