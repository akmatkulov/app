module SessionsHelper
  # Save user id in session
  def log_in(user)
    session[:user_id] = user.id
  end

  # Return current user of session or cookies
  def current_user
    if (user_id = session[:user_id])
        @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(:remember, cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end

  # Return true or false if present
  def logged_in?
    !!current_user
  end

  # Remember user and token in cookies and database
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end

  # Delete user in session
  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil
  end

  # Delete cookies
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  # Return if current user
  def current_user?(user)
    user == current_user
  end

  # Redirct to save path or default
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  # Save url
  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end
end
