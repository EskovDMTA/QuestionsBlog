class SessionsController < ApplicationController
    before_action :require_no_authentication, only: %i[new create]
    before_action :require_authentication, only: %i[destroy]
    
    def new
    end

    def create
        
        user = User.find_by email: params[:email]
        if user&.authenticate params[:password]
            sign_in user
            remember(user) if params[:remember] == "1"
            flash[:success] = "Login succesfully"
            redirect_to questions_path
        else
            redirect_to root_path
        end
    end

    def destroy
        sign_out
        flash[:success] = "GL HF"
        redirect_to questions_path
    end

    
end