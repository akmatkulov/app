class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      reset_session
      log_in user
      params[:session][:remember_me] == "1" ? remember(user) : forget(user)
      redirect_to user, flash: { success: "You are logged in" }
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
