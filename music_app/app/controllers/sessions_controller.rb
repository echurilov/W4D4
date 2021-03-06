class SessionsController < ApplicationController
  before_action :require_login, only: [:destroy]
  before_action :require_logout, only: [:new, :create]

  def new
    render :new
  end

  def create
    user = User.find_by_credentials(
      params[:user][:email],
      params[:user][:password]
    )
    byebug
    if user
      login!(user)
      redirect_to user_url(user)
    else
      flash.now[:errors] = ['Invalid Username or Password']
      render :new
    end
  end

  def destroy
    logout!
    redirect_to new_session_url
  end
end
