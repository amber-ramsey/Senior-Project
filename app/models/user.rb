class User < ApplicationRecord
  # validates FILL_IN, presence: true
  # validates FILL_IN, presence: true
  # validates FILL_IN, presence: true
  # validates FILL_IN, presence: true
  # validates FILL_IN, presence: true
  # validates :image,   content_type: { in: %w[image/jpeg image/gif image/png],
                      #                 message: "must be a valid image format" },
                      # size:         { less_than: 5.megabytes,
                      #                 message:   "should be less than 5MB" }
                      
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
end
