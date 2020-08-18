class SessionsController < ApplicationController

    def show
    end
    
    def new
    end
    
    def create
      if params[:user][:password] && params[:user][:username] 
        @user = User.find_by(username: params[:user][:username])
        return head(:forbidden) unless
            @user.authenticate(params[:user][:password])
        session[:user_id] = @user.id
        session[:username] = @user.username
        redirect_to hello_path
      else
        redirect_to login_path
      end
    end

    def destroy
      session.clear
      redirect_to login_path
    end

end