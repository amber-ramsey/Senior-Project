class ApplicationController < ActionController::Base
  include SessionsHelper

  add_flash_types :success, :error

protected

  def require_login
    unless logged_in?
      flash[:error] = "You must be logged in to access this page"
      redirect_to root_url
    end
  end

  def require_admin 
    unless admin?
      flash[:error] = "You do not have permission to access this page"
      redirect_back(fallback_location: root_path)
    end
  end
end
