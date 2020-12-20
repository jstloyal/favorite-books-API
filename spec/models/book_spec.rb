require 'rails_helper'

RSpec.describe Book, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should have_many(:favorite_books) }
    it { should have_many(:favorited_by) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:description) }
    it { is_expected.to validate_presence_of(:author) }
    it { is_expected.to validate_presence_of(:genre) }

    it do
      should validate_length_of(:title).is_at_least(2).is_at_most(30)
    end

    it do
      should validate_length_of(:genre).is_at_least(3).is_at_most(15)
    end

    it do
      should validate_length_of(:description).is_at_least(10).is_at_most(400)
    end
  end

  describe 'scopes' do
    before :each do
      @user = FactoryBot.create(:user)
      @book = @user.books.create!(title: 'Example',description: 'Example desx', genre: 'fiction', author: 'Example use')
    end

    it 'can be created by user' do
      expect(Book.first).to eq(@book)
    end

    it 'can be accessed by the author' do
      expect(@user.books.first).to eq(@book)
    end
  end
end