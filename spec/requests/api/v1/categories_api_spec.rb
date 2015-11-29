require 'rails_helper'

describe 'Categories API' do
  let(:user)     { create :user }
  let(:category) { create :category }

  # GET /api/v1/categories.json
  describe 'listing all categories' do
    let!(:google) { create :link, user: user, category: category }
    let!(:yahoo)  { create :link, user: user, category: category }

    before do
      get '/api/v1/categories.json', nil, auth_headers(user)
    end

    it 'returns a list of categories' do
      expect(response_body[:categories].count).to eq 1
    end
  end
end
