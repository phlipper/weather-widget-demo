class Location < ApplicationRecord
  validates :city, :state, :lat, :lng, presence: true
  validates :postal_code, length: { is: 5 }, presence: true, uniqueness: true
end
