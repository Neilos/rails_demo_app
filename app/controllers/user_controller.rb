class UserController < ApplicationController
  def index
  end

  def create
    @new_user = User.new({
      :first_name => params[:first_name],
      :last_name => params[:last_name],
      :email => params[:email],
      :password => params[:password],
      :password_confirmation => params[:password_confirmation]
    })
    if @new_user.valid?
      @new_user.save
      flash[:notice] = "Sign up successful. Now login."
      redirect_to :root
    else
      render :index
    end
    
  end

  def login
    @user = User.find_by_email(params[:login_email])
    if @user && @user.authenticate(params[:login_password])
      @user.update_attribute(:login_count, @user.login_count + 1)
      session[:user_id] = @user.id
      redirect_to :user_login_counter
    else
      flash[:notice] = "Password and/or email incorrect."
      redirect_to :root
    end
  end

  def login_counter
    @user = User.find_by_id(session[:user_id])
    @count = @user.login_count  
    @name = @user.first_name  
    render :logged_in
  end

  def logout
    session.clear
    flash[:notice] = "Logged Out"
    redirect_to '/'
  end
end
