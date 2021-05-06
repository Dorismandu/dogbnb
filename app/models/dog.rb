class Dog < ApplicationRecord
  belongs_to :user
  has_many_attached :photos
  has_many :bookings, dependent: :destroy

  geocoded_by :address
  before_save :geocode, if: :will_save_change_to_address?
  
  has_many :reviews, through: :bookings, dependent: :destroy
end
