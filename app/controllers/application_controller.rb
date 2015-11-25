class ApplicationController < ActionController::API
  include ActionController::HttpAuthentication::Basic::ControllerMethods
  include ActionController::HttpAuthentication::Token::ControllerMethods

  before_action :authenticate

  private

  attr_reader :current_user

  def authenticate
    uuid    = request.headers['X-API-UUID']
    token   = request.headers['X-API-TOKEN']

    if uuid.blank? || token.blank?
      basic_http_auth
      return
    end

    user = User.where(uuid: uuid, token: token).first
    user ? sign_in(user) : authentication_error
  end

  def basic_http_auth
    authenticate_or_request_with_http_basic do |email, password|
      if password == ENV['PASSWORD']
        user = User.where(email: email).first
        user ? sign_in(user) : false
      end
    end
  end

  def sign_in(user)
    @current_user = user
    GenerateNewToken.call(current_user)

    response.headers['X-API-UUID']  = current_user.uuid
    response.headers['X-API-TOKEN'] = current_user.token
    response.headers['Authorization'] = ''

    true
  end

  def authentication_error
    render json: { error: 'Unauthorized' }, status: :unauthorized
  end
end
