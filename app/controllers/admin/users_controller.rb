class Admin::UsersController < ApplicationController
    before_action :require_authentication
    before_action :set_user!, only: %i[edit update destroy]

    def index
      respond_to do |format|
        format.html do
          @pagy, @users = pagy User.order(created_at: :desc)
        end
        format.zip do
          respond_with_zipped_users
          end
        end
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
      if params[:archive].present?
        UserBulkService.call(params[:archive])
        flash[:success] = "Users upload" 
      end
      redirect_to admin_users_path
    end
    
    def destroy 
      @user.destroy
      flash[:success] = "User deleted"
      redirect_to admin_users_path
    end

    private 

    def respond_with_zipped_users
      compressed_filestream = Zip::OutputStream.write_buffer do |zos|
        User.order(created_at: :desc).each do |user|
          zos.put_next_entry "user#{user.id}.xlsx"
          zos.print render_to_string(
            layout: false, handlers: [:axlsx], formats: [:xlsx],
            template: "admin/users/user",
            locals: {user: user}
          )
        end
      end
      compressed_filestream.rewind
      send_data compressed_filestream.read, filename: "users.zip"
    end

    def set_user!
      @user = User.find params[:id]
  end

  def user_params
      params.require(:user).permit(:name, :email, :old_password, :password, :password_confirmation, :role).merge(admin_edit: true)
  end


end
