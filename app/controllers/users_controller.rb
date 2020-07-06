class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to root_path, flash: { notice: "Welcome #{@user.username}! Log in to begin." }
    else
      flash[:error] = "Account creation failed. See errors for more info"
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end