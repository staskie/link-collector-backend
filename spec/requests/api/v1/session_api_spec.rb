require 'rails_helper'

describe 'Session API' do
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

  describe 'session token' do
    context 'after signing in' do
      let!(:initial_token) { user.token }

      before do
        post '/api/v1/sessions', {
          email: user.email, password: 'password'
        }
      end

      it 'changes the user token for security reasons' do
        expect(user.reload.token).to_not eq initial_token
      end
    end
  end
end
