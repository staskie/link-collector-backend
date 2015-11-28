require 'rails_helper'

describe Link do
  it { should belong_to(:category) }
  it { should belong_to(:user) }

  it { should validate_presence_of(:url) }
  it { should validate_presence_of(:category) }

  describe '#category_name' do
    let(:category) { create :category }
    let(:link)     { create :link, category: category }

    it 'returns a category name' do
      expect(link.category_name).to eq category.name
    end
  end
end
