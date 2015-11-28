require 'rails_helper'

module Api::V1
  describe CategorySerializer do
    let!(:user)     { create :user }
    let!(:category) { create :category }
    let!(:link)     { create :link, user: user, category: category }

    subject { described_class.new(category).to_json }

    it 'returns a valid json response' do
      parsed_category_response = parse(subject)
      parsed_link_response     = parse(LinkSerializer.new(link).to_json)

      expect(parsed_category_response).to eq({
        id:    category.id,
        name:  category.name,
        links: [parsed_link_response]
      })
    end
  end
end
