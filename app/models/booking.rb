class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :dog
  has_one :review
end
