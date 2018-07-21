class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!

  # GET /orders
  # GET /orders.json
  def index
    if params[:term] or params[:min_date] or params[:max_date]
        @orders = Order.all
        condition_clauses = []
        condition_clauses << ['orders.status = ?',params[:term]] unless params[:term].blank?
        condition_clauses << ["orders.delivery_date >= ?", params[:min_date]] unless params[:min_date].blank?
        condition_clauses << ["orders.delivery_date <= ?", params[:max_date]] unless params[:max_date].blank?
        
        condition_clauses =  condition_clauses.map{|c| c.second }.prepend(condition_clauses.map{|c| c.first }.join(' AND ') ) unless condition_clauses.blank?
        p condition_clauses 
        @orders = @orders.where(condition_clauses)
        @orders = @orders.joins(:client).where('unaccent(lower(clients.name)) LIKE unaccent(?)',"%#{params[:client_name].downcase}%") unless params[:client_name].blank?
      # @orders = Order.where(:status => params[:term])
    else
      @orders = Order.ongoing
    end
  end
  
  
  # GET /orders/1
  # GET /orders/1.json
  def show
    respond_to do |format|
      format.html
      format.pdf do
        # render pdf: "order_pdf"   # Excluding ".pdf" extension.
        render pdf: "#{@order.id}",template: "orders/order_pdf.pdf.erb",encoding: 'utf8'
      end
    end
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)
    @frame = params[:order][:frame]
    
    params[:order][:passe_partout].shift
    @passe_partouts = params[:order][:passe_partout]
    
    params[:order][:accessory].shift
    @accessories = params[:order][:accessory]
    
    @products = @passe_partouts
    @products.append(@frame)
    @products.each do |prod|
      po = @order.product_orders.build(product_id: prod)
      po.save!
    end
    if @accessories.present?
      @accessories.each do |prod|
        po = @order.product_orders.build(product_id: prod)
        po.save!
      end
    end
    
    if params[:stimulation]
      @order.status = "stimulation"
    end
    respond_to do |format|
      if @order.save
        format.html { redirect_to cal_cost_path(order: @order), notice:  "Operação realizada com sucesso" }
        format.json  { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json  { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    
    respond_to do |format|
      if @order.update(order_params)
        if params[:cost_check]
          return redirect_to cal_cost_path(order: @order)
        end
        format.html { redirect_to order_path, notice: 'Encomenda actualizada com sucesso.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def cal_cost
    @order = Order.find(params[:order])
    @frame_cost = (@order.length + @order.height) * @order.products.frame.first.price + (8 * @order.products.frame.first.width)
    # @partout_prices = @order.products.passe_partout.pluck(:price)
    @partout_cost = 0
    @order.products.passe_partout.pluck(:price).each do |price|
      @partout_cost = @partout_cost + (@order.length * @order.height * price)
    end
    @accessories_cost = 0
    if @order.products.accessory.present?
      @order.products.passe_partout.pluck(:price).each do |price|
        @accessories_cost = @accessories_cost + (@order.length * @order.height * price)
      end
    end
    
    @cost = @frame_cost+@partout_cost+@accessories_cost
    @cost = @cost + @order.others unless @order.others.nil?
    @discount = ((@order.discount * @cost)/100).round(2)
    @cost = @cost.round(2) - @discount
    @taxcost = (@cost * current_user.vat.to_f)/100
    @cost = @taxcost + @cost
    @order.update!(cost: @cost, frame_cost: @frame_cost,passe_partout_cost: @partout_cost,accessory_cost: @accessories_cost, tax_cost: @taxcost, discount_amount: @discount)
    # respond_to do |format|
    #   format.html
    #   format.js
    # end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: "Acção concluída com sucesso" }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id]) or not_found
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:notes, :cost, :frame, :stimulation, :client_name, :client_phone, :status, :seller, :passe_partout, :accessory, :client_id, :delivery_date, :others, :length, :height, :advance, :discount, client_attributes: [:id, :name, :email,:phone_number,:phone_number2, :vat, :notes, :dob])
    end
end
