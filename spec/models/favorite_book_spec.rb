require 'rails_helper'

RSpec.describe FavoriteBook, type: :model do
  describe 'association' do
    it { should belong_to(:user) }
    it { should belong_to(:book) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:user_id) }
    it { is_expected.to validate_presence_of(:book_id) }
  end

  describe 'scopes' do
    before :each do
      @user = FactoryBot.create(:user)
      @book = @user.books.create!(title: 'Example', description: 'Desciption of example', author: 'Dem Ba', genre: 'Fiction')
      @favorite_book = @user.favorite_book.create!(book_id: @book.id)
    end

    it 'can be created by user' do
      expect(FavoriteBook.first).to eq(@favorite_book)
    end

    it 'can be accessed by the same user' do
      expect(@user.favorite_books.first).to eq(@favorite_book)
    end

    it 'can be accessed by the book' do
      expect(@book.favorite_books.first).to eq(@favorite_book)
    end
  end
end
