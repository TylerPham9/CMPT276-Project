class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :destroy]
  before_action :correct_user,   only: [:edit, :update]
  before_action :isadmin_user,   only: [:destroy, :promote, :admin]

  def show
    @user = User.find(params[:id])
  end
  def new
    @user = User.new
  end
  def index
    @user = User.all
  end
  def admin
    @user = User.all
  end

  def help
  end

  def about
  end

  def create
    @user = params[:user] ? User.new(users_params) : User.new_guest
    
      #After guest account is made, give it a random name and email
      if @user.guest 
        @user.username = "Guest_" + rand(9999).to_s
        @user.email = @user.username + "@guest.com"
      end 
      
      if @user.save
        log_in @user
        if @user.guest
          redirect_to root_url
        else
          flash[:success] = "Profile was successfully created!"
          redirect_to @user
        end
      else
        render 'new'
      end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(users_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end
 
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to admin_url
  end
  
  def promote
    @user = User.find(params[:id])
    if !@user.admin_user?
      @user.update_attribute(:admin_user, true)
      flash[:success] = "User is promoted to admin."
    else
      flash[:danger] = "Admins can't demote other admins."
    end
      redirect_to admin_url
  end
    
  
  private
    def users_params
      if params[:user]
        params.require(:user).permit(:username, :email, :password, :password_confirmation)
      else
      end
    end
    
    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end
    
    # Confirms the correct user.
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless @user == current_user
    end
    
    def isadmin_user
      redirect_to(root_url) unless current_user.admin_user?
    end
    
end
