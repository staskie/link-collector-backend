require 'rails_helper'

describe 'Authenticate API' do
  let(:user) { create :user }

  describe 'logging in with email and password' do

    before { subject }

    context 'when user and email are correct' do
      subject do
        post '/api/v1/sessions', {
          email: user.email, password: 'password'
        }
      end

      it 'returns an email, uuid and token' do
        expect(response_body).to eq({
          email: user.email,
          token: user.reload.token,
          uuid: user.uuid
        })
      end
    end

    context 'when user or email are incorret' do
      subject do
        post '/api/v1/sessions', {
          email: user.email, password: 'wrong_password'
        }
      end

      it 'returns `Unanturhozed`' do
        expect(response_body).to eq({
          error: 'Unauthorized'
        })
      end

      it 'returns 401 status' do
        expect(response.status).to eq 401
      end
    end
  end

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

  context 'after running a request' do
    let!(:initial_token) { user.token }

    before do
      get '/api/v1/links.json', nil, auth_headers(user)
    end

    it 'changes the user token for security reasons' do
      expect(user.reload.token).to_not eq initial_token
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
