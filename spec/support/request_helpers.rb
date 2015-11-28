module Request
  module Helpers
    def response_body
      parse(response.body)
    end

    def parse(json)
      JSON.parse(json).deep_symbolize_keys
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
