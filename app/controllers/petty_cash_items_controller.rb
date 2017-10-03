class PettyCashItemsController < ApplicationController
  load_and_authorize_resource
  before_action :set_petty_cash
  before_action :set_petty_cash_item, only: [:show, :edit, :update, :destroy]

  # GET /petty_cash_items
  # GET /petty_cash_items.json
  def index
    @petty_cash_items = @petty_cash.petty_cash_items.order("created_at DESC")

    respond_to do |format|
      format.js {}
    end
  end

  # GET /petty_cash_items/new
  def new
    @petty_cash_item = @petty_cash.petty_cash_items.new
    # @petty_cash_item.bal_carried_forward = @pet

    respond_to do |format|
      format.js {}
    end
  end

  # POST /petty_cash_items
  # POST /petty_cash_items.json
  def create
    @petty_cash_item = @petty_cash.petty_cash_items.new(petty_cash_item_params)

    respond_to do |format|
      if @petty_cash_item.save
        format.html { redirect_to petty_cashes_path, notice: 'Payment successfully created.' }
        format.json { render :show, status: :created, location: @petty_cash_item }
      else
        format.html { render :new }
        format.json { render json: @petty_cash_item.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    def set_petty_cash
      @petty_cash = PettyCash.find(params[:petty_cash_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_petty_cash_item
      @petty_cash_item = PettyCashItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def petty_cash_item_params
      params.require(:petty_cash_item).permit(:amount, :paid_to, :reason, :date, :site_id)
    end
end
