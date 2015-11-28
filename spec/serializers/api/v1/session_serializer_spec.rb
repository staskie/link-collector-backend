require 'rails_helper'

module Api::V1
  describe SessionSerializer do
    let(:user) { create :user }

    subject { described_class.new(user).to_json }

    it 'returns a valid json response' do
      expect(parse(subject)).to eq({
        email: user.email,
        uuid:  user.uuid,
        token: user.token
      })
    end
  end
end
