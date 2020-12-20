class Book < ApplicationRecord
  validates :title, presence: true, length: { minimum: 2, maximum: 30 }
  validates :description, presence: true, length: { minimum: 10, maximum: 320 }
  validates :author, presence: true, length: { minimum: 3, maximum: 30 }
  validates :genre, presence: true, length: { minimum: 3, maximum: 15 }

  belongs_to :user
  has_many :favorite_books, dependent: :destroy
  has_many :favorited_by, through: favorite_books, source: :user, dependent: :destroy
end
