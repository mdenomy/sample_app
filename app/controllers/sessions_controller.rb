class SessionsController < ApplicationController
  def new
    @title = "Sign In"
  end

  def create
    @title = "Sign In"
    user = User.authenticate(params[:session][:email], params[:session][:password])
    if user.nil?
      flash.now[:error] = "Invalid username/password"
      render 'new'
    elsif
      sign_in user
      redirect_to user
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end
end
