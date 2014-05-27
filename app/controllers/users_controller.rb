class UsersController < ApplicationController
  before_action :require_signin, except: [:new, :create, :show, :follow, :unfollow, :subscriptions, :followers]
  before_action :find_user, only: [:show, :edit, :update, :destroy, :follow, :unfollow, :subscriptions, :followers]
  before_action :require_current_user, except: [:new, :create, :show, :subscriptions, :followers, :follow, :unfollow]


  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      redirect_to @user
    else
      render :new
    end
  end

  def show

  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to root_path
  end

  def follow

    current_user.follow(@user)
    redirect_to user_path(@user)

  end

  def unfollow

    current_user.stop_following(@user)
    redirect_to user_path(@user)

  end

  def subscriptions

  end

  def followers
  end

  private

  def find_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(
      :first_name,
      :last_name,
      :email,
      :password,
      :password_confirmation,
      :avatar
    )
  end

  def require_current_user
    if !current_user?(@user)
      redirect_to root_path
    end
  end
end
