class User < ApplicationRecord
  has_many :turves, class_name: "Turf"
end
