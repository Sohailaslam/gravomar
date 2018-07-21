class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  
    def after_sign_in_path_for(resource)
        if current_user.admin
            admin_path
        else
            dashboard_path
        end
    end
    
    def not_found
        redirect_to root_path, notice: "Página não Encontrada"
    end
    
end
