class UsersController < ApplicationController
  
  def new
    @new_user = User.new
  end

  def create
    @new_user = User.new({
      :first_name => params[:user][:first_name],
      :last_name => params[:user][:last_name],
      :email => params[:user][:email],
      :password => params[:user][:password],
      :password_confirmation => params[:user][:password_confirmation]
    })

    if @new_user.valid?
      @new_user.save
      flash[:notice] = "Sign up successful. Now login."
      redirect_to :new_session
    else
      render :new
    end
  end

   def show
    @user = User.find_by_id(session[:user_id])
    @count = @user.login_count  
    @name = @user.first_name  
  end

end
