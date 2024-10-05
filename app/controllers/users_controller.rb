class UsersController < ApplicationController
  before_action :set_user, only: %i[ show ]
  def new
    redirect_to root_path if current_user.present?
    @user = User.new
  end
  def show; end
  def create
    @user = User.new(user_params)
    if @user.save
      log_in(@user)
      redirect_to @user, flash: { success: "Welcome to the Instagram!" }
    else
      render :new, status: :unprocessable_entity
    end
  end
  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:user_name, :name, :email, :password, :password_confirmation)
    end

    def logged_in_user
      unless logged_in?
        redirect_to login_path, flash: { danger: "Please log in." }
      end
    end
end
