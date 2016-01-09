class InvoiceNumbersController < ApplicationController
  before_action :set_invoice_number, only: [:show, :edit, :update, :destroy]

  # GET /invoice_numbers
  # GET /invoice_numbers.json
  def index
    @invoice_numbers = InvoiceNumber.all
  end

  # GET /invoice_numbers/1
  # GET /invoice_numbers/1.json
  def show
  end

  # GET /invoice_numbers/new
  def new
    @invoice_number = InvoiceNumber.new
  end

  # GET /invoice_numbers/1/edit
  def edit
  end

  # POST /invoice_numbers
  # POST /invoice_numbers.json
  def create
    @invoice_number = InvoiceNumber.new(invoice_number_params)

    respond_to do |format|
      if @invoice_number.save
        format.html { redirect_to @invoice_number, notice: 'Invoice number was successfully created.' }
        format.json { render :show, status: :created, location: @invoice_number }
      else
        format.html { render :new }
        format.json { render json: @invoice_number.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /invoice_numbers/1
  # PATCH/PUT /invoice_numbers/1.json
  def update
    respond_to do |format|
      if @invoice_number.update(invoice_number_params)
        format.html { redirect_to @invoice_number, notice: 'Invoice number was successfully updated.' }
        format.json { render :show, status: :ok, location: @invoice_number }
      else
        format.html { render :edit }
        format.json { render json: @invoice_number.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /invoice_numbers/1
  # DELETE /invoice_numbers/1.json
  def destroy
    @invoice_number.destroy
    respond_to do |format|
      format.html { redirect_to invoice_numbers_url, notice: 'Invoice number was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_invoice_number
      @invoice_number = InvoiceNumber.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def invoice_number_params
      params.require(:invoice_number).permit(:invoice_date, :sub_total, :value_added_tax, :total, :site_id)
    end
end
