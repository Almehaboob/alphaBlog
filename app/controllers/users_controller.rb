class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy ]
  before_action :require_user, except: [:new, :create ]


  def show
   
    @articles =@user.articles
  end 

  def index
    @users = User.all
  end

    def new
      @user = User.new
    end
  
    def create
      @user = User.new(user_params)
      if @user.save
        session[:user_id] = @user.id
        # Redirect to the user profile page (or somewhere else)
        flash[:notice] ='User created successfully!welcome #{@user.username}'
        redirect_to articles_path
      else
        # If there are errors, render the new form again
        render :new
      end
    end

    def destroy
      @user.destroy
      session[:user_id] = nil
      flash[:notice]= "account and all associated articles deleted successfully"
      redirect_to login_path
    end




    def edit
    end


    def update
    
      if @user.update(user_params)
        flash[:notice] ="updated successfully"
        redirect_to articles_path
      else
        render 'edit'
      end
    end




  

  
    private
  
    def user_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation)
    end


    def set_user
      @user=User.find(params[:id])
    end
  end
  