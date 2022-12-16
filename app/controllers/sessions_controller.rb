class SessionsController < ApplicationController
    def new
    end
    
    def create
      user = User.find_by(email: params[:email])
      if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        if session[:intented_url]
          redirect_to session[:intented_url]
          session[:intented_url]= nil
        else
          redirect_to user
        end
      else
        flash.now[:alert] = "Your Email or Password is incorrect!!"
        render :new
      end
    end

    def destroy
      session[:user_id] = nil
    end

    def sign_out
      session[:user_id] = nil
      redirect_to movies_path, notice: "Signing out successfully!"
    end
end
