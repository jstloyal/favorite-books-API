require 'rails_helper'
require 'json'

RSpec.describe '/books', type: :request do
  before :each do
    @user = User.create!(name: 'Bimpe', email: 'bimbim@gmail.com', password: '123456', nickname: 'Bimbim')
    post '/api/v1/auth', params: { email: @user.email, password: '123456' }
  end

  describe 'GET /items' do
    it 'returns an empty array if there is no item in the database' do
      get books_url
      expect(JSON.parse(response.body)).to eq([])
    end

    it 'returns an array with the items in the database' do
      img = fixture_file_upload('files/photo.jpg', 'image/jpg')
      params = { title: 'Diallo is here', description: 'Read before you leap', author: 'Manuel', genre: 'fiction', user_id: @user.id, image: img }
      post books_url, params: params
      get books_url

      expect(JSON.parse(response.body).length).to eq(1)
    end
  end

  describe 'GET /books/:id' do
    it 'returns an error message if not found' do
      expect do
        post books_url(999)
      end.to raise_error(ActionsController::RoutingError)
    end

    it 'returns the element if found' do
      img = fixture_file_upload('files/photo.jpg', 'image/jpg')
      params = { title: 'Diallo', description: 'Read before you leap', author: 'Manuel', genre: 'fiction', user_id: @user.id, image: img }
      post books_url, params: params
      book = JSON.parse(response.body)

      get "/books/#{book[:id]}/"
      resp = JSON.parse(response.body)
      expect(resp[0]['title']).to eq('Diallo')
    end

    describe 'POST /books' do
      context 'with valid parameters' do
        it 'creates a new Book' do
          expect do
            img = fixture_file_upload('files/photo.jpg', 'image/jpg')
            params = { title: 'Diallo', description: 'Read before you leap', author: 'Manuel', genre: 'fiction', user_id: @user.id, image: img }
            post books_url, params: params
          end.to change(Book, :count).by(1)
        end
      end

      context 'with invalid parameters' do
        it 'does not create a new Book' do
          expect do
            post books_url, params: { title: 'John DOe' }
          end.to change(Book, :count).by(0)
        end
      end
    end
  end
end