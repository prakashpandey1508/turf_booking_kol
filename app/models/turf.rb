class Turf < ApplicationRecord
  belongs_to :user
  has_many :bookings, dependent: :destroy
  validates :name, presence: true
  validates :pin_code, presence: true
  validates :address, presence: true
  validates :price_per_hour,
            presence: true,
            numericality: { only_integer: true, greater_than: 0 }

end
