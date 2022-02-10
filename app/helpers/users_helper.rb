module UsersHelper

  def promote(user)
    if user.isAdmin == false
      if user.update(isAdmin: true)
        redirect_to users_path, success: 'User is successfully promoted to Admin'
      else
        redirect_to users_path, error: 'There was an error when attempting to promote the user to Admin'
      end
    end
  end
end
