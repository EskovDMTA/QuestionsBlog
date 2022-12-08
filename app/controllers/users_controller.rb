class UsersController < ApplicationController
    before_action :require_no_authentication, only: %i[new create]
    before_action :require_authentication, only: %i[edit update]
    before_action :set_user!, only: %i[edit update]

    def new
        @user = User.new
    end

    def update
        if @user.update user_params
            flash[:success] = "Profile updated"
            redirect_to edit_user_path(@user)
        else
            render plain: @user.errors.full_messages
        end
    end

    
    def create
        @user = User.new user_params
        if @user.save
            session[:user_id] = @user.id
            flash[:success] = "Welcome to AskIt, #{current_user.name_or_email}"
            redirect_to questions_path
        else
            render :new
        end
    end

    private

    def set_user!
        @user = User.find params[:id]
    end

    def user_params
        params.require(:user).permit(:name, :email, :old_password, :password, :password_confirmation)
    end
end