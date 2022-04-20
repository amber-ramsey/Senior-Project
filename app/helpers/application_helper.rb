module ApplicationHelper
  # Returns the full title on a per-page basis.
  def full_title(page_title = '')
    base_title = "Inquest"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  # taken from session helper
  # Returns the current logged-in user (if any).
  def current_user
    if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
    end
  end

  def logged_in?
    !current_user.nil?
  end

  def admin?
    logged_in? && current_user.isAdmin
  end
end
