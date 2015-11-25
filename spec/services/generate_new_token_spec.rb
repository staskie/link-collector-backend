require 'spec_helper'
require_relative '../../app/services/generate_new_token'

describe GenerateNewToken do
  let(:user) { double('User') }

  subject { described_class.call(user) }

  before do
    allow(SecureRandom).to receive(:hex)
      .and_return('585ded56ad073a2137ad90c263a53171')
  end

  it 'generates a new token' do
    expect(user).to receive(:update_attributes)
      .with(token: '585ded56ad073a2137ad90c263a53171')

    subject
  end
end
