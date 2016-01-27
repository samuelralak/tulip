class InvoicesController < ApplicationController
  load_and_authorize_resource
  before_action :set_invoice_number, only: [:show, :edit, :update, :destroy]

  # GET /invoice_numbers
  # GET /invoice_numbers.json
  def index
    @invoices = Invoice.all
  end

  # GET /invoice_numbers/1
  # GET /invoice_numbers/1.json
  def show
    respond_to do |format|
      format.pdf do
        render pdf: "invoice#{@invoice.invoice_number}"   # Excluding ".pdf" extension.
      end
    end
  end

  # GET /invoice_numbers/new
  def new
    @invoice = Invoice.new
  end

  # GET /invoice_numbers/1/edit
  def edit
  end

  # POST /invoice_numbers
  # POST /invoice_numbers.json
  def create
    @invoice = Invoice.new(invoice_number_params)

    respond_to do |format|
      if @invoice.save
        format.html { redirect_to invoices_path, notice: 'Invoice number was successfully created.' }
        format.json { render :show, status: :created, location: @invoice }
      else
        format.html { render :new }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /invoice_numbers/1
  # PATCH/PUT /invoice_numbers/1.json
  def update
    respond_to do |format|
      if @invoice.update(invoice_number_params)
        format.html { redirect_to invoices_path, notice: 'Invoice number was successfully updated.' }
        format.json { render :show, status: :ok, location: @invoice }
      else
        format.html { render :edit }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /invoice_numbers/1
  # DELETE /invoice_numbers/1.json
  def destroy
    @invoice.destroy
    respond_to do |format|
      format.html { redirect_to invoice_numbers_url, notice: 'Invoice number was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_invoice_number
      @invoice = Invoice.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def invoice_number_params
      params.require(:invoice).permit(:invoice_date, :sub_total, :value_added_tax, :total, :site_id, :amount, :note)
    end
end
