class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update ]
  before_action :logged_in_user, only: %i[ edit update index ]
  before_action :correct_user, only: %i[ edit update ]

  def show; end
  def edit; end

  def index
    @users = User.all
  end
  def new
    redirect_to root_path if current_user.present?
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in(@user)
      redirect_to @user, flash: { success: "Welcome to the Instagram!" }
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), flash: { success: "Proflie updated" }
    else
      render :edit, status: :unprocessable_entity
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
        store_location
        flash[:success] = "Please login."
        redirect_to login_path, status: :see_other
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url, status: :see_other) unless current_user?(@user)
    end
end
