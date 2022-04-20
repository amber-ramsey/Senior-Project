class PasswordResetsController < ApplicationController
  before_action :get_user,  only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]

  def new
  end 

  def create 
    @user = User.find_by(email: params[:password_reset][:email].downcase)
    if @user
        @user.create_reset_digest
        @user.send_password_reset_email 
        flash[:info] = "Email sent with password reset instructions"
        redirect_to root_url
    else
        flash.now[:danger] = "Email address not found"
        render 'new'
    end
  end

  def edit
      @user = User.find_by_password_reset_token!(params[:id])
      respond_to do |format|
          format.html { render "edit" }
          format.js { render "edit" }
      end 
  end 

  def update
    if params[:user][:password].empty?
        @user.errors.add(:password, "can't be empty") 
        render 'edit'
    elsif @user.valid?(:pword) && @user.update(user_params)
        reset_session
        log_in @user
        flash[:success] = "Password has been reset."
        redirect_to @user
    else 
        render 'edit'
    end 
  end 

  private

    def user_params
        params.require(:user).permit(:password, :password_confirmation)
    end

    def get_user
        @user = User.find_by(email: params[:email])
        redirect_to root_url
    end

    def check_expiration
        if @user.password_reset_expired?
            flash[:danger] = "Password reset has expired."
            redirect_to new_password_reset_url
        end
    end
end
