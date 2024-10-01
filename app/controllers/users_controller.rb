class UsersController < ApplicationController
  before_action :set_user, only: %i[ show ]
  def new
    @user = User.new
  end
  def show; end
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Instagram!"
      redirect_to @user
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
end
