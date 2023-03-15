class UsersController < ApplicationController
    before_action :logged_in_user, except: %i(show new create)
    before_action :correct_user, only: %i(edit update)
    #before_action :load_user, only: except: %i(index new create)
    before_action :admin_user, only: :destroy
    def new
        @user = User.new
    end

    def index
        @pagy, @users = pagy(User.all, items:
            Setting.page_10)
    end
    def show
        @user = User.find_by id: params[:id]
        return if @user
        flash[:warning] = "Not found user!"
        redirect_to root_path 
    end
    def create
        @user = User.new user_params # Not the final implementation!
        if @user.save
        # Handle a successful save.
            log_in @user
            flash[:success] = "User create successful"
            redirect_to @user
        else
            render :new
        end
    end

    def edit
        @user = User.find(params[:id])
    end

    def update
        @user = User.find(params[:id])
        if @user.update(user_params)
            flash[:success] = "Profile updated"
            redirect_to @user
        else
            render 'edit'
        end
    end
    def destroy
        if @user.destroy
            flash[:success] = "User deleted"
        else
            flash[:danger] = "Delete fail!"
        end
        redirect_to users_path
    end

    private
    def user_params
        params.require(:user).permit :name, :email, :password, :password_confirmation
    end

    # Confirms the correct user.
    def correct_user
        return if @user == current_user
        flash[:error] = "You cannot edit this account."
        redirect_to root_url
    end

    def logged_in_user
        unless logged_in?
            store_location
            flash[:danger] = "Please log in."
            redirect_to login_url
        end
    end

    def admin_user
        redirect_to root_path unless current_user.admin?
    end
end