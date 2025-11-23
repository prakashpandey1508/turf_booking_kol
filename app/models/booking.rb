class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :turf
  STATUS = { pending: 0, confirmed: 1, cancelled: 2, completed: 3 }.freeze
end
