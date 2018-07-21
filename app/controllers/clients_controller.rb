class ClientsController < ApplicationController
    def index
        @clients = Client.all
        # if params[:term]
        #     @clients = Client.where(status: params[:term])
        # else
        #     @clients = Client.where(status: "registered")
        # end
        respond_to do |format|
            format.html
            format.csv { send_data @clients.to_csv, filename: "clients-#{Date.today}.csv" }
        end
    end
    def destroy
        @client = Client.find(params[:id])
        @client.destroy
    
        respond_to do |wants|
            wants.html { redirect_to(clients_url) }
            wants.xml  { head :ok }
        end
    end
    
    def new
        @client = Client.new
        @order = Order.find(params[:order]) if params[:order]
    end
    
    def create
        @client = Client.new(user_params)
        @client.save!
        
        if params[:order]
            @order = Order.find(params[:order])
            @order.update(client_id: @client.id)
            redirect_to @order, notice: "Cliente adicionado."
        else
            redirect_to admin_path, notice: "Cliente adicionado."
        end
    end
    
    def edit
        @user = Client.find(params[:id])
        
        if params[:term] or params[:min_date] or params[:max_date]
        @orders = Order.where(client_id: @user.id)
        condition_clauses = []
        condition_clauses << ['orders.status = ?',params[:term]] unless params[:term].blank?
        condition_clauses << ["orders.delivery_date >= ?", params[:min_date]] unless params[:min_date].blank?
        condition_clauses << ["orders.delivery_date <= ?", params[:max_date]] unless params[:max_date].blank?
        
        condition_clauses =  condition_clauses.map{|c| c.second }.prepend(condition_clauses.map{|c| c.first }.join(' AND ') ) unless condition_clauses.blank?
        @orders = @orders.where(condition_clauses)
        @orders = @orders.joins(:client).where('unaccent(lower(clients.name)) LIKE unaccent(?)',"%#{params[:client_name].downcase}%") unless params[:client_name].blank?
          # @orders = Order.where(:status => params[:term])
        else
          @orders = Order.where(client_id: @user.id, status: "ongoing")
        end
    end
    
    def update
        @user = Client.find(params[:id])
        if @user.update(user_params)
            redirect_to clients_path, notice: "Dados de cliente actualizados com sucesso"
        else
            redirect_to clients_path, notice: @user.errors.full_messages.join
        end
    end
    
    private
    def user_params
        params.require(:client).permit(:name, :email,:phone_number,:phone_number2, :vat, :notes, :dob, :status)
    end
end
