class UsersController < ApplicationController
  before_action :locate, only: [:show, :edit, :update, :destroy]
  before_action :require_login, only: [:edit, :update, :destroy]
  before_action :require_logout, only: [:new, :create]

  def locate
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
    render :new
  end

  def show
    render :show
  end

  def edit
    render :edit
  end

  def create
    @user = User.new(user_params)
    if @user.save!
      login!
      show
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def update
    if @user.update(user_params)
      show
    else
      flash.now[:errors] = @user.errors.full_messages
      edit
    end
  end

  def destroy
    @user.destroy
    redirect_to new_session_url
  end

  private

  def user_params
    params.require(:user).permit(:email,:password)
  end
end
