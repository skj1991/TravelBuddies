class UsersController < ApplicationController
    def index
        @users = User.all
    end

    def show
        set_user
    end

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            session[:user_id] = @user.id 
            redirect_to user_path(@user), :flash => {:success => "Welcome to Travel Buddies, #{@user.name}!"} 
        else 
            render :new
        end
    end

    private

    def user_params
        params.require(:user).permit(:email, :name, :password_digest)
    end
end
