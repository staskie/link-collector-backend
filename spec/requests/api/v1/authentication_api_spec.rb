require 'rails_helper'

describe 'Authenticate API' do
  let(:user) { create :user }

  context 'when UUID and token are set' do
    before do
      get '/api/v1/links.json', nil, auth_headers(user)
    end

    it 'signs in a user' do
      expect(response.headers['X-API-UUID']).to eq user.uuid
      expect(response.headers['X-API-TOKEN']).to eq user.reload.token
    end

    it 'returns requested resources' do
      expect(response_body).to include(links: [])
    end
  end

  context 'when neither UUID nor token is set' do
    it 'responds with basic auth' do
      get '/api/v1/links.json'
      expect(response.body).to eq "HTTP Basic: Access denied.\n"
    end
  end

  context 'when token is invalid' do
    before do
      get '/api/v1/links.json', nil, {
        'X-API-UUID' => user.uuid,
        'X-API-TOKEN' => 'invalid_token'
      }
    end

    it 'responds with unauthorized' do
      expect(response_body).to eq({ error: 'Unauthorized' })
    end
  end

  context 'when doing Basic AUTH' do
    context 'and both email and password are valid' do
      before do
        get '/api/v1/links.json', nil, basic_auth(user.email, 'password')
      end

      it 'signs in a user' do
        expect(response.headers['X-API-UUID']).to eq user.uuid
        expect(response.headers['X-API-TOKEN']).to eq user.reload.token
      end

      it 'sets a current_user' do
        expect(assigns(:current_user)).to eq user
      end
    end

    context 'and email is invalid' do
      before do
        get '/api/v1/links.json', nil,
          basic_auth('invalid.email@example.com', 'password')
      end

      it 'keeps requesting a basic auth' do
        expect(response.body).to eq "HTTP Basic: Access denied.\n"
      end
    end

    context 'and password is invalid' do
      before do
        get '/api/v1/links.json', nil, basic_auth(user.email, 'wront_password')
      end

      it 'keeps requesting a basic auth' do
        expect(response.body).to eq "HTTP Basic: Access denied.\n"
      end
    end
  end
end
