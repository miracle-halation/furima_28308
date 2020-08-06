class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items
  has_many :orders

  with_options presence: true do
    validates :nickname
    validates :family_name, format: { with: CONSTANT::FULL_WIDTH_REGEX, message: 'is invalid. Input full-width characters.' }
    validates :family_name_reading, format: { with: CONSTANT::FULL_WIDTH_KATAKANA_REGEX, message: 'is invalid. Input full-width katakana characters.' }
    validates :first_name, format: { with: CONSTANT::FULL_WIDTH_REGEX, message: 'is invalid. Input full-width characters.' }
    validates :first_name_reading, format: { with: CONSTANT::FULL_WIDTH_KATAKANA_REGEX, message: 'is invalid. Input full-width katakana characters.' }
    validates :birthday
  end
  validates :email, format: { with: /\A^\S+@\S+\.\S+$\z/, message: 'is invalid. Input @ character.' }
  validates :password, format: { with: /\A[a-zA-Z0-9]+\z/, message: 'is invalid. Input half-width characters.' }
end
