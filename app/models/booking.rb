class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :dog
  belongs_to :review
end
