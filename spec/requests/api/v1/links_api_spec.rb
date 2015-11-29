require 'rails_helper'

describe 'Links API' do
  let(:user) { create :user }
  let(:category) { create :category }

  # GET /api/v1/links
  describe 'available links' do
    let!(:google) { create :link, user: user, category: category }
    let!(:yahoo)  { create :link, user: user, category: category }

    before do
      get '/api/v1/links.json', nil, auth_headers(user)
    end

    it 'returns a list of links' do
      expect(response_body[:links].count).to eq 2
    end
  end

  # POST /api/v1/links
  describe 'create a link' do
    subject do
      post '/api/v1/links.json', {
        link: {
          category_name: 'Search Engine',
          url: 'http://google.com'
        }
      }, auth_headers(user)
    end

    context 'when parameters are valid' do
      it 'creates a new link' do
        expect { subject }.to change(Link, :count).by(1)
      end

      it 'returns `created` status' do
        subject
        expect(response.status).to eq 201
      end
    end

    context 'when parameters are invalid' do
      subject do
        post '/api/v1/links.json', {
          link: {
            category_name: 'Invalid',
            url: ''
          }
        }, auth_headers(user)
      end

      it 'does not create a link' do
        expect { subject }.to change(Link, :count).by(0)
      end

      it 'returns a reason of failure' do
        subject
        expect(response_body[:error]).to include(url: ["can't be blank"])
      end

      it 'returns `unprocessable_entity` status' do
        subject
        expect(response.status).to eq 422
      end
    end
  end

  # PATCH /api/v1/links/:id
  describe 'update a link' do
    let(:link) { create :link, category: category, user: user }

    context 'when parameters are valid' do
      subject do
        patch "/api/v1/links/#{link.id}.json", {
          link: {
            url: 'http://google.com'
          }
        }, auth_headers(user)
      end

      before { subject }

      it 'updates the link' do
        expect(link.reload.url).to eq 'http://google.com'
      end

      it 'returns `:ok` status' do
        expect(response.status).to eq 200
      end
    end

    context 'when parameters are invalid' do
      subject do
        patch "/api/v1/links/#{link.id}.json", {
          link: {
            url: ''
          }
        }, auth_headers(user)
      end

      before { subject }

      it 'returns errors' do
        expect(response_body[:error]).to include(url: ["can't be blank"])
      end

      it 'returns `:unprocessable_entity` status' do
        expect(response.status).to eq 422
      end
    end
  end

  # DELETE /api/v1/links/:id
  describe 'remove a link' do
    let!(:link) { create :link, user: user }

    subject do
      delete "/api/v1/links/#{link.id}.json", {}, auth_headers(user)
    end

    it 'returns `ok` status' do
      subject
      expect(response.status).to eq 200
    end

    it 'deletes a link' do
      expect { subject }.to change(Link, :count).by(-1)
    end

    it 'returns an id of a deleted link' do
      subject
      expect(response_body).to eq({
        message: 'Link removed',
        id: link.id
      })
    end
  end


  # GET /api/v1/categories/:category_id/links
  describe 'links for a given category' do
    let(:other_category) { create :category, name: 'Misc' }

    let!(:google) { create :link, user: user, category: category }
    let!(:yahoo)  { create :link, user: user, category: category }
    let!(:bing)   { create :link, user: user, category: other_category }

    before do
      get "/api/v1/categories/#{category.id}/links", {}, auth_headers(user)
    end

    it 'returns links that belongs to the category' do
      expect(response_body[:category_links].size).to eq 2
    end
  end

end
