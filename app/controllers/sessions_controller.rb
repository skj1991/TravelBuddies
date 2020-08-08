class SessionsController < ApplicationController
    def new
    end

    def altcreate
    @user = User.find_or_create_by(uid: auth['uid']) do |u|
            u.name = auth['info']['name']
            u.email = auth['info']['email']
            u.image = auth['info']['image']
            u.password = 'password'
        end
        @user.save
        session[:user_id] = @user.id
        redirect_to users_path(@user), :notice => "Signed in!"
    end

     def create
         @user = User.find_by(email: params[:user][:email])
         if @user && @user.authenticate(params[:user][:password])
             session[:user_id] = @user.id
             redirect_to users_path(@user)
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
