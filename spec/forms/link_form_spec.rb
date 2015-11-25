require 'rails_helper'

describe LinkForm do
  context 'when creating a new link object' do
    let(:link) { Link.new }

    subject { described_class.new(link) }

    context 'when passing all required parameters' do
      xit 'creates a link'
    end

    context 'when parameters are invalid' do
      xit 'does not create a link'
    end
  end

  context 'when updating an existing link object' do
    let(:link) { create :link }

    subject { described_class.new(link) }

    context 'when passing all required parameters' do
      xit 'updates a link'
    end

    context 'when parameters are invalid' do
      xit 'does not update a link'
    end
  end
end
