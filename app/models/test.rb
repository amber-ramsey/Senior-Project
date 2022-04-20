class Test < ApplicationRecord
  belongs_to :user
  has_many :questions, dependent: :destroy

  validates(:name, presence: true, length: { in: 2...50})
  validates(:user_id, presence: true)
  validate(:private, unless: -> { !(password.blank?) })
  validates(:private, presence: true, unless: -> { password.blank? })
  validate(:password, if: :private?)
  validates(:password, presence: true, length: { minimum: 3 }, unless: :private?)
  validates(:time, length: { in: 0...4 }, numericality: { only_integer: true }, allow_blank: true)

  def private?
    private == false
  end
end
