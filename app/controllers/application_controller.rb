class ApplicationController < ActionController::Base
    protect_from_forgery with: :null_session

    def require_login
        return head(:forbidden) unless session.include? :user_id
    end

end
