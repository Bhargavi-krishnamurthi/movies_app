class ApplicationController < ActionController::Base
    
    def current_user
        @current_user ||= User.find(session[:user_id]) if session[:user_id]
    end
    
    def current_user?
        @user = User.find(params[:id])
        @user == current_user
    end

    def current_user_admin?
        current_user && current_user.admin?
    end

    def require_admin
        redirect_to movies_path, alert: "You are not authorized to perform this action!" unless current_user_admin?
    end

    def require_sign_in
        if !current_user
            session[:intented_url] = request.url
            redirect_to sign_in_path
        end
    end


    helper_method :current_user 
    helper_method :current_user?
    helper_method :current_user_admin?
end
