class Book < ApplicationRecord
  include Rails.application.routes.url_helpers

  belongs_to :user

  has_many :favorite_books, dependent: :destroy

  has_many :favorited_by, through: :favorite_books, source: :user, dependent: :destroy

  has_one_attached :image

  validates :title, presence: true, length: { minimum: 2, maximum: 40 }

  validates :description, presence: true, length: { minimum: 6, maximum: 50_000 }
  validates :author, presence: true, length: { minimum: 3, maximum: 30 }
  validates :genre, presence: true, length: { minimum: 3, maximum: 15 }

  def set_host
    Rails.env.production? ? 'https://favbooks-api.herokuapp.com/' : 'http://localhost:3000'
  end
  
  def image_url
    if image.nil?
      "<img src='http://loremflickr.com/600/800/man' alt='Book' />"
    else
      rails_representation_url(image.variant(resize: '600x800'), host: set_host)
    end
  end
end
