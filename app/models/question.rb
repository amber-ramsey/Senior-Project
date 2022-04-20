class Question < ApplicationRecord
  belongs_to :test
  has_many :test_responses, dependent: :destroy
  has_one_attached :picture, dependent: :destroy

  validates(:query, presence: true, length: { maximum: 200})
  validates(:ch1, presence: true, length: { maximum: 200})
  validates(:ch2, presence: true, length: { maximum: 200})
  validates(:ch3, allow_blank: true, length: { maximum: 200})
  validates(:ch4, allow_blank: true, length: { maximum: 200})
  validates(:ch5, allow_blank: true, length: { maximum: 200})
  validates(:ch6, allow_blank: true, length: { maximum: 200})
  validates(:ch7, allow_blank: true, length: { maximum: 200})
  validates(:ch8, allow_blank: true, length: { maximum: 200})
  validates(:ch9, allow_blank: true, length: { maximum: 200})
  validates(:ch10, allow_blank: true, length: { maximum: 200})
  validates(:correct, presence: true, exclusion: { in: %w(0), message: "must choose a correct answer" })
  validates(:test_id, presence: true)

  validates(:picture,
    content_type: {in: %w[jpeg gif png],
    message: "must be a valid image format"},
    size: {less_than: 5.megabytes,
    message: "should be less than 5MB"})

  # might make this smaller still
  def display_pic
    picture.variant(resize_to_limit: [1000, 1000]).processed
  end

  def delete_pic
    @question.picture.purge_later
    ActiveStorage::Blob.unattached.find_each(&:purge_later)
    redirect_to edit_test_question_path(@question.id, @question.test_id)
  end
end
