class TestResponse < ApplicationRecord
  belongs_to :user
  belongs_to :question

  validates(:began_at, presence: true)
  validates(:left_at, presence: true)
  validates(:response, presence: { strict: true, message: "must choose a correct answer" })
end
