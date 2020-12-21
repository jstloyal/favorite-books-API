class Book < ApplicationRecord
  include Rails.application.routes.url_helpers

  belongs_to :user
  has_many :favorite_books, dependent: :destroy
  has_many :favorited_by, through: favorite_books, source: :user, dependent: :destroy
  has_one_attached :image

  validates :title, presence: true, length: { minimum: 2, maximum: 30 }
  validates :description, presence: true, length: { minimum: 10, maximum: 400 }
  validates :author, presence: true, length: { minimum: 3, maximum: 30 }
  validates :genre, presence: true, length: { minimum: 3, maximum: 15 }
  validates :image, presence: true

  def set_host
    Rails.env.production? ? 'https://favbooks-api.herokuapp.com/' : 'http://localhost:3000'
  end
  
  def image_url
    image.nil? nil : rails_representation_url(image.variant(resize: '400x600'), host: set_host)
  end
end
