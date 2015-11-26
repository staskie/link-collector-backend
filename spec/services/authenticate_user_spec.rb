require 'rails_helper'

describe AuthenticateUser do
  let(:user)  { create(:user, email: 'john.doe@example.com') }

  context 'when email and password are valid' do
    subject { described_class.call('john.doe@example.com', 'password') }

    before do
      allow(User).to receive(:find_by)
        .with(email: 'john.doe@example.com')
        .and_return(user)
      allow(GenerateNewToken).to receive(:call)
    end

    it 'returns a user' do
      expect(subject).to eq user
    end

    it 'generates a new token for the new session' do
      expect(GenerateNewToken).to receive(:call)
      expect(subject).to eq user
    end
  end

  context 'when email and pssord are invalid' do
    subject { described_class.call('wrong.email', 'password') }

    it 'receives nil' do
      expect(subject).to be_nil
    end
  end
end
