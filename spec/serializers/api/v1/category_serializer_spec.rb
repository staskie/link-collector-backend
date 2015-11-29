require 'rails_helper'

module Api::V1
  describe CategorySerializer do
    let!(:user)     { create :user }
    let!(:category) { create :category }
    let!(:link)     { create :link, user: user, category: category }

    subject { described_class.new(category).to_json }

    it 'returns a valid json response' do
      parsed_category_response = parse(subject)

      expect(parsed_category_response).to eq({
        id:    category.id,
        name:  category.name
      })
    end
  end
end
