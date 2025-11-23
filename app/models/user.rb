class User < ApplicationRecord
  has_many :turves, class_name: "Turf"
  has_many :bookings
end
