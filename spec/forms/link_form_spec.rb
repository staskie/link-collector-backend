require 'rails_helper'

describe LinkForm do
  let(:category) { create :category, name: 'Search Engine' }

  let(:valid_params) do
    {
      category_name: category.name,
      url: 'http://yahoo.co.uk'
    }
  end

  let(:invalid_params) do
    {
      category_name: category.name,
      url: ''
    }
  end

  context 'when creating a new link object' do
    let(:link) { Link.new }

    subject { described_class.new(link) }

    context 'when passing all required parameters' do
      it 'creates a link' do
        expect { subject.submit(valid_params) }.to \
          change(Link, :count).by(1)
      end
    end

    context 'when parameters are invalid' do
      it 'does not create a link' do
        expect { subject.submit(invalid_params) }.to \
          change(Link, :count).by(0)
      end

      it 'returns errors from link object' do
        subject.submit(invalid_params)

        expect(subject.errors[:url]).to include("can't be blank")
      end
    end
  end

  context 'when updating an existing link object' do
    let(:link) { create :link, category: category }

    subject { described_class.new(link) }

    context 'when passing all required parameters' do
      it 'updates a link' do
        valid_params.merge!(category_name: 'Engines')
        subject.submit(valid_params)

        expect(link.reload.category.name).to eq 'Engines'
      end
    end

    context 'when parameters are invalid' do
      it 'does not update a link' do
        invalid_params.merge!(category_name: 'Engines')
        subject.submit(invalid_params)

        expect(link.reload.category.name).to eq category.name
      end
    end
  end

  describe 'submitting a category name' do
    let(:link) { Link.new }

    subject { described_class.new(link) }

    context 'when a category name from params does not exists' do
      it 'creates a new category name' do
        expect { subject.submit(valid_params) }.to \
          change(Category, :count).by(1)
      end
    end

    context 'when a category name from parameters already exists' do
      before { category }

      it 'assigns an existing category name' do
        expect { subject.submit(valid_params) }.to \
          change(Category, :count).by(0)
      end
    end
  end
end
