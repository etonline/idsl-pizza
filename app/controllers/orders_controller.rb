class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy, :done]

  # GET /categories
  # GET /categories.json
  def index
    @orders = Order.all
  end

  # GET /categories/1
  # GET /categories/1.json
  def show
    @order_details = @order.order_detail
  end

  # GET /categories/new
  def new
    @order = Order.new
  end

  # GET /categories/1/edit
  def edit
  end

  # POST /categories
  # POST /categories.json
  def create
    @order = Order.new(order_params)
    @order.status = "shopping"
    @user = User.find(order_params[:user_id])
    if !@user.blank?
      if @user.current_order_id.blank?
        respond_to do |format|
          if @order.save
            @user.current_order_id = @order.id
            @user.save
            format.html { redirect_to @order, notice: 'Order was successfully created.' }
            format.json { render :show, status: :created, location: @order }
          else
            format.html { render :new }
            format.json { render json: @order.errors, status: :unprocessable_entity, :id => "0" }
          end
        end
      else
        render :json => { :id => "0", :error => "User already have pending order."}
      end
    else
      render :json => { :id => "0", :error => "Cannot find specified user."}
    end
  end

  # PATCH/PUT /categories/1
  # PATCH/PUT /categories/1.json
  def update
    @user = User.find(@order.user_id)
    @user.current_order_id = nil
    @user.save
    respond_to do |format|
      if @order.update(order_params)
        @user = User.find(@order.user_id)
        @user.current_order_id = @order.id
        @user.save
        format.html { redirect_to @order, notice: 'Category was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    @user = User.find(@order.user_id)
    @user.current_order_id = nil
    @user.save
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_path, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def done
    if @order.status == "shopping"
      @order.status = "delivering"
      total = 0
      @order.order_detail.each do |order_detail|
        product = Product.find(order_detail.product_id)
        total = total + product.price * order_detail.quantity
        if product.order_count.blank?
          product.order_count = 1
        else
          product.order_count = product.order_count + 1
        end
        product.save
      end
      @order.total_price = total
      user = User.find(@order.user_id)
      if user.bonus <= total
        @order.bonus = user.bonus
        new_bonus = (total - user.bonus) * 0.1
        user.bonus = new_bonus.round
      else
        @order.bonus = user.bonus - total
        new_bonus = user.bonus - total
        user.bonus = new_bonus.round
      end
      user.current_order_id = 0
      user.save
      @order.order_time = Time.now()
      @order.save
      redirect_to order_path(@order, format: :json)
    else
      render :json => { :id => "0"}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      if !params[:id].blank?
        @order = Order.find(params[:id])
      else
        @order = Order.find(params[:order_id])
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:user_id, :deliver_time, :total_price, :bonus, :pay_type_id, :deliver_address, :contact_phone, :status)
    end

end
