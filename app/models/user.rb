class User < ApplicationRecord
  has_many :tests, dependent: :destroy
  has_many :test_responses, dependent: :destroy

  attr_accessor :reset_token

  before_save { self.email = email.downcase }
  VALID_NAME_REGEX = /\A[a-z][a-z\'\-]+([\ a-z][a-z\'\-]+)*\z/i
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  with_options on: :editable do    
    validates(:firstName, presence: true, length: { in: 2...50}, format: { with: VALID_NAME_REGEX })
    validates(:lastName, presence: true, length: { in: 2...50}, format: { with: VALID_NAME_REGEX })
    validates(:email, presence: true, length: { maximum: 80 }, format: { with: VALID_EMAIL_REGEX }, uniqueness: true)
    validates(:schoolID, presence: true, numericality: { only_integer: true }, length: { is: 6 }, uniqueness: true)
  end

  with_options on: :pword do
    validates(:password, presence: true, length: { minimum: 6 }, allow_nil: true, confirmation: {case_sensitive: true})
    validates(:password_confirmation, presence: true)
  end

  # def new_email?
  #   @user = User.find(params[:id])
  #   :email != @user.email
  # end

  # def new_id?
  #   @user = User.find(params[:id])
  #   :schoolID != @user.schoolID
  # end
  
  has_secure_password
  

  # default_scope { order(firstName: :asc) }
        
  # before_create { generate_token(:auth_token) }

  # def send_password_reset 
  #     generate_token(:password_reset_token)
  #     self.password_reset_sent_at = Time.zone.now 
  #     save!
  #     UserMailer.password_reset(self).deliver 
  # end 

  # def generate_token(column)
  #     begin 
  #         self[column] = SecureRandom.urlsafe_base64
  #     end while User.exists?(column => self[column])
  # end 
  
  # Sets the password reset attributes.
  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest,  User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  # Sends password reset email.
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  # Returns true if a password reset has expired.
  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end
  
end
