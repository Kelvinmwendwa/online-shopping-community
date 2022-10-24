class UsersController < ApplicationController 

    def new
        @user = User.new
    end 

    def index
    end 

    def show
        @user = User.find_by(id: session[:user_id])
        if @user 
            render json: @user 
        else 
            render json: { error: "Not authorized" }, status: :unauthorized 
        end
    end 

    def create 
        @user = User.new(user_params) 
        if @user.save and @user.valid?
            session[:user_id] = @user.id 
            render 'users/new' 
        else 
            render :action => "new" 
        end
    end 

    private 

    def user_params 
        params.require(:user).permit(:name, :username, :email, :location, :password_digest )
    end 

end
