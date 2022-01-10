class Test < ApplicationRecord
  belongs_to :user
  has_many :questions
  default_scope -> { order(:name) }
end
