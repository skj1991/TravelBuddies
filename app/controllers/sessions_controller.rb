class SessionsController < ApplicationController
    def new
    end

    def altcreate
        @user = User.new_from_oauth(auth)
        session[:user_id] = @user.id
        redirect_to users_path, :notice => "Signed in!"
    end

     def create
         @user = User.find_by(email: params[:user][:email])
         if @user && @user.authenticate(params[:user][:password])
             session[:user_id] = @user.id
             redirect_to users_path
         else
            
             redirect_to login_path, :flash => { :error => "Incorrect username/password. Please try again."}
         end
    end

    def destroy
        session.destroy
        redirect_to root_path, :notice => "Sucessfully Logged Out!"
    end

    private

    def auth
        request.env['omniauth.auth']
    end
end
