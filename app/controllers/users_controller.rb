class UsersController < ApplicationController
    before_action :authenticate_user!
    
    # def index
    
    # end 
    
    # def new
    #     @client = User.new
    # end
    
    # def create
    #     @client = User.new(user_params)
    #     @client.skip_confirmation!
    #     @client.password = "password"
    #     @client.save!
    #     redirect_to admin_path, notice: "Cliente adicionado."
    # end
    
    def edit
        @user = User.find(params[:id])
    end
    
    def update
        @user = User.find(params[:id])
        if @user.update(user_params)
            redirect_to edit_user_path, notice: "Perfil de utilizador actualizado com sucesso"
        else
            redirect_to edit_user_path, notice: @user.errors.full_messages.join
        end
    end
    
    private
    def user_params
        params.require(:user).permit(:name, :email,:phone_number,:phone_number2, :vat, :notes, :dob)
    end
end
