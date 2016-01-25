class PettyCashesController < ApplicationController
  before_action :set_petty_cash, only: [:show, :edit, :update, :destroy]

  # GET /petty_cashes
  # GET /petty_cashes.json
  def index
    @petty_cashes = PettyCash.order("created_at DESC")
  end

  # GET /petty_cashes/1
  # GET /petty_cashes/1.json
  def show
  end

  # GET /petty_cashes/new
  def new
    @petty_cash = PettyCash.new
  end

  # GET /petty_cashes/1/edit
  def edit
  end

  # POST /petty_cashes
  # POST /petty_cashes.json
  def create
    @petty_cash = PettyCash.new(petty_cash_params)

    respond_to do |format|
      if @petty_cash.save
        format.html { redirect_to petty_cashes_path, notice: 'Petty cash was successfully created.' }
        format.json { render :show, status: :created, location: @petty_cash }
      else
        format.html { render :new }
        format.json { render json: @petty_cash.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /petty_cashes/1
  # PATCH/PUT /petty_cashes/1.json
  def update
    respond_to do |format|
      if @petty_cash.update(petty_cash_params)
        format.html { redirect_to petty_cashes_path, notice: 'Petty cash was successfully updated.' }
        format.json { render :show, status: :ok, location: @petty_cash }
      else
        format.html { render :edit }
        format.json { render json: @petty_cash.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /petty_cashes/1
  # DELETE /petty_cashes/1.json
  def destroy
    @petty_cash.destroy
    respond_to do |format|
      format.html { redirect_to petty_cashes_url, notice: 'Petty cash was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_petty_cash
      @petty_cash = PettyCash.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def petty_cash_params
      params.require(:petty_cash).permit(:paid_to, :amount, :reason, :date_paid, :source, :balance)
    end
end
