require 'rails_helper'

describe 'Links API' do

  let(:user) { create :user }
  let(:category) { create :category }

  describe 'list available links' do
    let!(:google) { create :link, user: user, category: category }
    let!(:yahoo)  { create :link, user: user, category: category }

    before do
      get '/api/v1/links.json', nil, auth_headers(user)
    end

    it 'returns a list of links' do
      expect(response_body[:links].count).to eq 2
    end
  end

  describe 'create a link' do
    subject {
      post '/api/v1/links.json', { link: {
        category_id: category.id,
        user_id: user.id,
        url: 'http://google.com'
      }},
      auth_headers(user)
    }

    it 'creates a new link' do
      expect { subject }.to change(Link, :count).by(1)
    end

    it 'returns correct status' do
      subject
      expect(response.status).to eq 201
    end
  end
end
