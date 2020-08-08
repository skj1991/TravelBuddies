class UsersController < ApplicationController
    #before_action :require_login 

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
            redirect_to user_path(@user), :flash => { :success => "Welcome, #{@user.name}! Your account was successfully created."}
        else
            render :new
        end
    end


    private

    def user_params
        params.require(:user).permit(:email, :name, :password)
    end
end
