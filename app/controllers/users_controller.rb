class UsersController < ApplicationController
  before_filter :login_required, except: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to home_path, notice: "Thank you for signing up! You are now logged in."
    else
      render action: 'new'
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update_attributes(user_params)
      redirect_to home_path, notice: "Your profile has been updated."
    else
      render action: 'edit'
    end
  end

  private
  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end
