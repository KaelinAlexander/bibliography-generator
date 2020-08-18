class UsersController < ApplicationController

    def show
    end

    def new
    end

    def create
        if params[:user][:password] == params[:user][:password_confirmation]
            @user = User.create(user_params)
            session[:user_id] = @user.id
            session[:username] = @user.username
            redirect_to @user
        else
            redirect_to signup_path
        end
    end
    
    private

    def user_params
        params.require(:user).permit(:username, :email, :password, :password_confirmation)
    end

end