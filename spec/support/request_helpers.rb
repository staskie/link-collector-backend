module Request
  module Helpers
    def response_body
      JSON.parse(response.body).deep_symbolize_keys
    end

    def basic_auth(email, password)
      {
        'HTTP_AUTHORIZATION' => ActionController::HttpAuthentication::Basic
          .encode_credentials(email, password)
      }
    end

    def auth_headers(user)
      {
        'X-API-UUID' => user.uuid,
        'X-API-TOKEN' => user.token
      }
    end
  end
end

