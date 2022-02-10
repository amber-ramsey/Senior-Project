class Question < ApplicationRecord
  belongs_to :test
  has_one_attached :picture
end
