class UsersController < ApplicationController
  before_action :require_signin, except: [:new, :create, :show]
  before_action :find_user, only: [:show, :edit, :update, :destroy]
  before_action :require_current_user, except: [:new, :create, :show]


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
    @user = User.find(params[:id])

    current_user.follow(@user)
    redirect_to '/users/<%= current_user.id.to_s %>/subscriptions'

    # if current_user
    #   if current_user == @user
    #     flash[:error] = "You cannot follow yourself."
    #   else
    #     current_user.follow(@user)
    #     RecommenderMailer.new_follower(@user).deliver if @user.notify_new_follower
    #     flash[:notice] = "You are now following #{@user.first_name} #{@user.last_name}."
    #   end
    # else
    #   flash[:error] = "You must <a href='/signin'>login</a> to follow #{@user.first_name} #{@user.last_name}.".html_safe
    # end
  end

  def unfollow
    @user = User.find(params[:id])

    if current_user
      current_user.stop_following(@user)
      flash[:notice] = "You are no longer following #{@user.first_name} #{@user.last_name}."
    else
      flash[:error] = "You must <a href='/signin'>login</a> to unfollow #{@user.first_name} #{@user.last_name}.".html_safe
    end
  end

  def subscriptions
    @user = User.find(params[:id])
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
      :password_confirmation
    )
  end

  def require_current_user
    if !current_user?(@user)
      redirect_to root_path
    end
  end
end
