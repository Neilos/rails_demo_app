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
    render :logged_in
  end

  def logout
    render :index
  end
end
