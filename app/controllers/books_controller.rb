class BooksController < ApplicationController
  before_action :set_book, only: %i[show update destroy]
  before_action :authenticate_api_user!, only: %i[update favorite destroy]

  def index
    @books = Book.all.order('created_at DESC')
    # render json: @books.to_json(include: %i[user favorited_by image])
    render json: serialize_books(@books)
  end

  def show
    render json: serialize_book(@book)
  end

  def create
    @book = Book.new(book_params)

    if @book.save
      # render json: @book.to_json(include: %i[user favorited_by image]), status: :created, location: @book
      render json: serialize_book(@book), status: :created, location: @book
    else
      render json: @book.erros.full_messages, status: :unprocessable_entity
    end
  end

  def update
    if @book.update(book_params)
      # render json: @book.to_json(include: %i[user favorited_by image])
      render json: serialize_book(@book)
    else
      render json: @book.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    @book.destroy
    render json: serialize_book(@book)
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
    params.permit(:user_id, :title, :author, :description, :genre, :ratings, :image)
  end

  def serialize_books(books)
    books.map { |book| serialize_book(book) }
  end

  def serialize_book(book)
    {
      id: book.id,
      title: book.title,
      description: book.description,
      author: book.author,
      genre: book.genre,
      ratings: book.ratings,
      image_url: book.image_url,
      created_at: book.created_at,
      updated_at: book.updated_at,
      user_id: book.user_id,
      user_name: book.user.name,
      favorited_by: book.favorited_by
    }
  end
end
