require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_many(:books) }
    it { should have_many(:favorites) }
    it { should have_many(:favorite_books) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:nickname) }
    it { is_expected.to validate_presence_of(:email) }
  end

  describe 'scopes' do
    before :each do
      @user = User.create!(name: 'Bimpes', email: 'bimbim@gmail.com', password: '123456', nickname: 'bimbim')
    end

    it 'can be created and accesed' do
      expect(User.first).to eq(@user)
    end
  end
end