# frozen_string_literal: true

class User < ActiveRecord::Base
  extend Devise::Models
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  include DeviseTokenAuth::Concerns::User

  validates :name, presence: true, length: { minimum: 6, maximum: 35 }
  validates :nickname, presence: true, length: { minimum: 6, maximum: 18 }

  has_many :books, dependent: :destroy
  has_many :favorite_books, dependent: :destroy
  has_many :favorites, through: :favorite_books, source: :item, dependent: :destroy
end
