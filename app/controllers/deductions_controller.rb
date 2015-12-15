class DeductionsController < ApplicationController
  before_action :get_painters
  before_action :set_painter, except: [:all]
  before_action :set_deduction, only: [:show, :edit, :update, :destroy]

  def all
    @deductions = Deduction.all
  end

  # GET /deductions
  # GET /deductions.json
  def index
    @deductions = Deduction.all
  end

  # GET /deductions/1
  # GET /deductions/1.json
  def show
  end

  # GET /deductions/new
  def new
    @deduction = Deduction.new
  end

  # GET /deductions/1/edit
  def edit
  end

  # POST /deductions
  # POST /deductions.json
  def create
    @deduction = Deduction.new(deduction_params)

    respond_to do |format|
      if @deduction.save
        format.html { redirect_to @deduction, notice: 'Deduction was successfully created.' }
        format.json { render :show, status: :created, location: @deduction }
      else
        format.html { render :new }
        format.json { render json: @deduction.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /deductions/1
  # PATCH/PUT /deductions/1.json
  def update
    respond_to do |format|
      if @deduction.update(deduction_params)
        format.html { redirect_to @deduction, notice: 'Deduction was successfully updated.' }
        format.json { render :show, status: :ok, location: @deduction }
      else
        format.html { render :edit }
        format.json { render json: @deduction.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /deductions/1
  # DELETE /deductions/1.json
  def destroy
    @deduction.destroy
    respond_to do |format|
      format.html { redirect_to deductions_url, notice: 'Deduction was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_painter
      @painter = Painter.find(params[:painter_id])    
    end

    def get_painters
      @painters = Painter.order('name ASC')
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_deduction
      @deduction = Deduction.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def deduction_params
      params.require(:deduction).permit(:date, :reason, :amount)
    end
end
