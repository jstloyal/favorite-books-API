class BooksController < ApplicationController
  before_action :set_book, only: %i[show update destroy]
  before_action :authenticate_api_user!, only: %i[create update favorite destroy]

  def index
    @books = Book.all.order('created_at DESC')
    render json: @books.to_json(include: %i[user favorited_by image])
  end

  def show
    render json: @book.to_json(include: %i[user favorited_by image])
  end

  def create
    @book = Book.new(book_params)

    if @book.save
      render json: @book.to_json(include: %i[user favorited_by image]), status: :created, location: @book
    else
      render json: @book.erros.full_messages, status: :unprocessable_entity
    end
  end

  def update
    if @book.update(book_params)
      render json: @book.to_json(include: %i[user favorited_by image])
    else
      render json: @book.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    @book.destroy
    render json: @book.to_json(include: %i[user favorited_by image])
  end

  def favorite
    type = params[:type]
    if type == 'favorite'
      current_api_user.favorites << @book unless current_api_user.favorites.include? @book
      render json: { success: true, message: "You favorited #{@book.title}" }
    elsif type == 'unfavorite'
      current_api_user.favorites.delete(@book) if current_api_user.favorites.include? @book
      render json: { success: true, message: "Unfavorited #{@book.title}" }
    else
      render json: { success: false, message: "Type of request is missing (favorite/unfavorite)" }, status: :unprocessable_entity
    end
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:item).permit(:user_id, :title, :author, :description, :genre, :ratings, :image)
  end
end
