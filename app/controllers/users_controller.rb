class UsersController < ApplicationController

    def show
        @user = User.find(session[:user_id])
        @bibliographies = @user.bibliographies
    end

    def new
        @user = User.new
    end

    def create
        if params[:user][:password] == params[:user][:password_confirmation]
            @user = User.new(user_params)
                if @user.valid?
                    @user.save
                    session[:user_id] = @user.id
                    session[:username] = @user.username
                    redirect_to @user
                else
                    render :new
                end
        else
           render :new
        end
    end

    private

    def user_params
        params.require(:user).permit(:username, :email, :password, :password_confirmation)
    end

end