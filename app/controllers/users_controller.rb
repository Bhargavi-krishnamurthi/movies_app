class UsersController < ApplicationController

    before_action :require_sign_in, except: [:new, :create]
    before_action :require_current_user, only: [:edit, :update, :destroy]


    def require_current_user
        redirect_to @user, alert: "You cannot perform this action!" unless current_user?
    end

    def index
        @users = User.all
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
            redirect_to @user, notice: "Account is created successfully!"
        else
            render :new
        end
    end

    def edit
        @user = User.find(params[:id])
    end

    def update
        @user = User.find(params[:id])
        if @user.update(user_params)
            redirect_to @user, notice: "User is updated successfully!"
        else
            render :new
        end
    end

    def destroy
        @user = User.find(params[:id])
        @user.destroy
        redirect_to users_path, alert: "Account is deleted!!"
    end


    private

    def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation, :user_name)
    end
end
