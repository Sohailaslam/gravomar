class HomeController < ApplicationController
    before_action :authenticate_user!, except: [:home]
    
    def home
    end
    
    def dashboard
        @client = current_user
    end
    
    def admin
        # render :layout => false
        # byebug
    end
end
