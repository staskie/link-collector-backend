require 'rails_helper'

module Api::V1
  describe LinkSerializer do
    let!(:user)     { create :user }
    let!(:category) { create :category }
    let!(:link)     { create :link, user: user, category: category }

    subject { described_class.new(link).to_json }

    it 'returns a valid json response' do
      parsed_response = parse(subject)

      expect(parsed_response).to eq({
        id:            link.id,
        url:           link.url,
        category_name: link.category_name
      })
    end
  end
end
