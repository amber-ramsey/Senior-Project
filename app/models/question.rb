class Question < ApplicationRecord
  belongs_to :test
  has_one_attached :picture
  validates :picture,
    content_type: {in: %w[picture/jpeg picture/gif picture/png],
    message: "must be a valid image format"},
    size: {less_than: 5.megabytes,
    message: "should be less than 5MB"}

  def display_pic
    picture.variant(resize_to_limit: [1000, 1000])
  end

  # not sure if this works
  def delete_pic
    @question.picture.find_by_id(params[:attachment_id]).purge
  end
end
