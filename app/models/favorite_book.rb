class FavoriteBook < ApplicationRecord
  validates_presence_of :user_id
  validates_presence_of :book_id
  
  belongs_to :user
  belongs_to :book
end
