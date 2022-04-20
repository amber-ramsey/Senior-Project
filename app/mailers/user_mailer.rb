class UserMailer < ApplicationMailer
  # make an email to send the password reset from
  default from: "#{ENV["YOUR_DEFAULT_EMAIL"]}"
  
  def password_reset(user)
      @user = user 
      mail to: user.email, subject: "Password Reset"
  end 
end