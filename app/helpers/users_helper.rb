module UsersHelper

  # error with redirect_to
  def promote(user)
    if user.isAdmin == false
      if user.update(isAdmin: true)
        # redirect_to users_url, success: 'User is successfully promoted to Admin'
      else
        # redirect_to users_url, error: 'There was an error when attempting to promote the user to Admin'
      end
    end
  end
end
