require 'rails_helper'

describe User do

  it { should have_many(:links) }

  it { should validate_presence_of(:email) }
  it { should validate_uniqueness_of(:email) }
  it { should validate_uniqueness_of(:uuid) }

  context 'before creating a user' do
    subject { User.create email: 'john.doe@example.com' }

    it 'generates a uuid' do
      expect(subject.uuid).to be
    end

    it 'generates a token' do
      expect(subject.token).to be
    end

    context 'and uuid is already taken' do
      let!(:first_user) { User.create(email: 'john.doe@example.com') }
      let(:uniq_uuid) { '585ded56ad073a2137ad90c263a53171' }

      before do
        allow(SecureRandom).to receive(:hex)
          .and_return(first_user.uuid, uniq_uuid)
      end

      subject { User.create(email: 'hallie.doe@example.com', token: 'abc') }

      it 'generates a new unique uuid' do
        expect(subject.uuid).to eq uniq_uuid
      end
    end
  end
end
