class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show]

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

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render 'new'
    end
  end

  def show
  end

  def is_guest?
    current_user && current_user.guest?
  end

  private
    def set_user
      @user = current_user
    end

    def user_params
      params.require(:user).permit(:email, :full_name, :display_name, :password, :password_confirmation)
    end
end
