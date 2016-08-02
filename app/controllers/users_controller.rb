class UsersController < ApplicationController
  #setting default users
  before_action :set_user,      only:   [:show, :edit, :update, :destroy]
  #check if alredy logged in
  before_action :require_login, only:   [:edit, :update, :destroy]
  #check if correct user
  before_action :correct_user,  except: [:index, :new, :show, :create ]

  before_action :require_logout,  only: [:new]


  def index
    @users = User.paginate(page: params[:page])
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
  @user = User.new(user_params)
  if @user.save
    log_in @user
    flash[:success] = "Welcome to the Sample App!"
    redirect_to @user
  else
    render 'new'
  end
end

   def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
      User.find(params[:id]).destroy
      flash[:success] = "User deleted"
      redirect_to users_url
    end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
  end

  def set_user
        @user = User.find(params[:id])
      end


      # Confirms the correct user.
      def correct_user
        @user = User.find(params[:id])

        unless current_user?(@user)
          flash[:warning] = "You are not the actual user"
          redirect_to root_url
        end
      end

      def require_login
      #check if the user is logged in or not
      unless logged_in?
        flash[:danger] = "You need to log in first!"
        redirect_to root_url # halts request cycle
      end
    end

      def require_logout
        if logged_in?
          flash.now[:warning] = "You must logged out to create a new user"
          redirect_to root_url
        end
      end
end
