require 'rails_helper'

describe UserCategoriesQuery do
  let!(:user)        { create :user }

  let!(:programming) { create :category, name: 'Programming' }
  let!(:marketing)   { create :category, name: 'Marketing' }

  let!(:link_one)    { create :link, category: programming, user: user }
  let!(:link_two)    { create :link, category: programming, user: user }

  describe '.call' do
    subject { described_class.call(user) }

    it 'returns unique categories used by a given user' do
      expect(subject).to eq [programming]
    end
  end
end
