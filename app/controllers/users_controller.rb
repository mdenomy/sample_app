class UsersController < ApplicationController
  before_filter :authenticate, :only => [:edit, :update, :index, :destroy]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user, :only => [:destroy]

  def index
    @title = "All users"
    @users = User.paginate(:page => params[:page])
  end

  def new
    redirect_to root_path if signed_in?
    @user = User.new
    @title = "Sign up"
  end

  def destroy
    user_to_destroy  = User.find(params[:id])
    if current_user != user_to_destroy
      user_to_destroy.destroy
      flash[:success] = "User destroyed."
    else
      flash[:error] = "Cannot delete yourself"
    end
    redirect_to users_path
  end

  def show
    @user = User.find(params[:id])
    @title = @user.name
  end

  def create
    if signed_in?
      redirect_to root_path if signed_in?
    else
      @user = User.new(params[:user])
      if @user.save
        flash[:success] = "Welcome to the Sample App!"
        sign_in @user
        redirect_to @user
      else
        @title = "Sign up"
        @user.password.clear
        @user.password_confirmation.clear
        render 'new'
      end
    end
  end

  def edit
    @title = "Edit user"
  end

  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "Settings updated"
      redirect_to @user
    else
      @title = "Edit user"
      render 'edit'
    end
  end

  private

  def authenticate
    deny_access unless signed_in?
  end

  def correct_user
    @user = User.find(params[:id])
    redirect_to(root_path) unless current_user?(@user)
  end

  def admin_user
     redirect_to(root_path) unless current_user.admin?
   end




end
