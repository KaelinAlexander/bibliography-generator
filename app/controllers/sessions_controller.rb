class SessionsController < ApplicationController

    def show
    end
    
    def new
    end
    
    def create
      if !User.all.empty? && params[:user][:password] && params[:user][:password] != "" && params[:user][:username] && params[:user][:username] != ""
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

    def create_omni
      @user = User.find_or_create_by(uid: auth['uid']) do |u|
        u.username = auth['info']['name']
        u.email = auth['info']['email']
        u.image = auth['info']['image']
        u.password = SecureRandom.urlsafe_base64
      end
      session[:user_id] = @user.id
      session[:username] = @user.username
      redirect_to user_path(@user)
    end

    def destroy
      session.clear
      redirect_to login_path
    end

    private

    def auth
      request.env['omniauth.auth']
    end

end