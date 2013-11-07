class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      current_user.move_to(@user) if is_guest?
      session[:user_id] = @user.id
      redirect_to orders_path, :notice => "Signed up!"
    else
      render "new"
    end
  end

  def is_guest?
    current_user && current_user.guest?
  end

  private
    def set_user
      @user = user.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email, :full_name, :display_name, :password, :password_confirmation, :admin)
    end
end
