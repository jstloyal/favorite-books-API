require 'rails_helper'
require 'json'

RSpec.describe '/books', type: :request do
  before :each do
    @user = User.create!(name: 'Bimpes', email: 'bimbim@gmail.com', password: '123456', nickname: 'Bimbim')
    post '/api/v1/auth', params: { email: @user.email, password: '123456' }
  end

  describe 'GET /books' do
    it 'returns an empty array if there is no book in the database' do
      get books_url
      expect(JSON.parse(response.body)).to eq([])
    end

    it 'returns an array with the books in the database' do
      img = fixture_file_upload('files/photo.jpeg', 'image/jpeg')
      params = {
        title: 'Diallo is here', description: 'Read before you leap',
        author: 'Manuel', genre: 'fiction', user_id: @user.id, image: img
      }
      post books_url, params: params
      get books_url

      expect(JSON.parse(response.body).length).to eq(1)
    end
  end

  describe 'GET /books/:id' do
    it 'returns the element if found' do
      img = fixture_file_upload('files/photo.jpeg', 'image/jpeg')
      params = {
        title: 'Diallo', description: 'Read before you leap',
        author: 'Manuel', genre: 'fiction', user_id: @user.id, image: img
      }
      post books_url, params: params
      book = JSON.parse(response.body)

      get "/books/#{book[:id]}/"
      resp = JSON.parse(response.body)
      expect(resp[0]['title']).to eq('Diallo')
    end
  end

  describe 'POST /books' do
    context 'with valid parameters' do
      it 'creates a new Book' do
        expect do
          img = fixture_file_upload('files/photo.jpeg', 'image/jpeg')
          params = {
            title: 'Diallo', description: 'Read before!',
            author: 'Manuel', genre: 'fiction', user_id: @user.id, image: img
          }
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

  describe 'POST /books/:id/favorite' do
    it 'does not work if there is not authenticated_api_user whis is active only when using the API' do
      img = fixture_file_upload('files/photo.jpeg', 'image/jpeg')
      params = {
        title: 'Diallo', description: 'Read before!', author: 'Manuel', genre: 'fiction', user_id: @user.id, image: img
      }
      post books_url, params: params
      book = JSON.parse(response.body)

      put "/books/#{book['id']}/favorite", params: { type: 'favorite' }
      resp = JSON.parse(response.body)

      expect(resp['errors'][0]).to eq('You need to sign in or sign up before continuing.')
    end
  end

  describe 'DELETE /books/:id' do
    it 'does not work if not signed in, cannot sign in due to rails using authenticated_api_user in the controller' do
      img = fixture_file_upload('files/photo.jpeg', 'image/jpeg')
      params = {
        title: 'Diallo', description: 'Read before!', author: 'Manuel', genre: 'fiction', user_id: @user.id, image: img
      }
      post books_url, params: params
      book = JSON.parse(response.body)

      delete "/books/#{book['id']}/"

      expect(Book.first).to be_truthy
    end
  end
end
