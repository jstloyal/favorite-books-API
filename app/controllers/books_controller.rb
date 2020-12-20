class BooksController < ApplicationController
  before_action :set_book, only: %i[show update destroy]
  before_action :authenticate_api_user!, only: %i[create update favorite destroy]

  def index
    @books = Book.all
    render json: @books.to_json(include: %i[user favorited_by])
  end

  def show
    render json: @books.to_json(include: %i[user favorited_by])
  end

  def create
    @book = Book.new(book_params)

    if @book.save
      render json: @book, status: :created, location: @book
    else
      render json: @book.erros, status: :unprocessable_entity
    end
  end

  def update
    if @book.update(book_params)
      render json: @book
    else
      render json: @book.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @book.destroy
  end

  def favorite
    type = params[:type]
    if type == 'favorite'
      current_user.favorites << @recipe
      render json: { success: true, message: "You favorited #{@recipe.title}" }
    elsif type == 'unfavorite'
      current_user.favorites.delete(@recipe)
      render json: { success: true, message: "Unfavorited #{@recipe.title}" }
    else
      render json: { success: false }, status: :unprocessable_entity
    end
  end

  private

  def set_book
    @book = Book.find(params[:id])
  end

  def book_params
    params.require(:item).permit(:user_id, :title, :author, :description, :genre, :ratings)
  end
end
