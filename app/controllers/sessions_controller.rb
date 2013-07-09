class SessionsController < ApplicationController

  def create
    @user = User.find_by_email(params[:session][:login_email])
    if @user && @user.authenticate(params[:session][:login_password])
      @user.update_attributes!(:login_count => @user.login_count + 1)
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      flash[:notice] = "Password and/or email incorrect."
      redirect_to :root
    end
  end

  def new
    redirect_to :root
  end

  def destroy
    session.clear
    flash[:notice] = "Logged Out"
    redirect_to :root
  end
end
