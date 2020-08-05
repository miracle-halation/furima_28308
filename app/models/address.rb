class Address < ApplicationRecord
	extend ActiveHash::Associations::ActiveRecordExtensions
	belongs_to :item
	belongs_to_active_hash :prefecture

	with_options presence: true do
		validates :postal_code, format: {with: /\A[0-9]{3}-[0-9]{4}/, messages: 'is invalid. Include hyphen(-)'}
		validates :prefecture_id, numericality: { other_than: 1 }
		validates :city
		validates :house_number
		validates :phone_number, format: {with: /\A^0\d{9,10}$\z/, messages:"is invalid. Exclude hyphen(-)"}, length: {maximum: 11} 
	end

end
