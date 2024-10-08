class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      forwarding_url = session[:forwarding_url]
      reset_session
      params[:session][:remember_me] == "1" ? remember(user) : forget(user)
      log_in user
      flash[:success] = "You are logged in"
      redirect_to forwarding_url || user
    else
      flash.now[:danger] = "Invalid email/password"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_path
  end
end
