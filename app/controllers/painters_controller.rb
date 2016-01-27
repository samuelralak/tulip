class PaintersController < ApplicationController
  load_and_authorize_resource
  before_action :set_painter, only: [:show, :edit, :update, :destroy, :deactivate]

  # GET /painters
  # GET /painters.json
  def index
    @painters = Painter.all
  end

  # GET /painters/1
  # GET /painters/1.json
  def show
  end

  # GET /painters/new
  def new
    @painter = Painter.new
    @painter.build_painter_contact
    @painter.build_next_of_kin
  end

  # GET /painters/1/edit
  def edit
  end

  # POST /painters
  # POST /painters.json
  def create
    @painter = Painter.new(painter_params)

    respond_to do |format|
      if @painter.save
        format.html { redirect_to @painter, notice: 'Painter was successfully created.' }
        format.json { render :show, status: :created, location: @painter }
      else
        format.html { render :new }
        format.json { render json: @painter.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /painters/1
  # PATCH/PUT /painters/1.json
  def update
    respond_to do |format|
      if @painter.update(painter_params)
        format.html { redirect_to @painter, notice: 'Painter was successfully updated.' }
        format.json { render :show, status: :ok, location: @painter }
      else
        format.html { render :edit }
        format.json { render json: @painter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /painters/1
  # DELETE /painters/1.json
  def destroy
    @painter.destroy
    respond_to do |format|
      format.html { redirect_to painters_url, notice: 'Painter was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def deactivate
    @painter.is_active = false;

    respond_to do |format|
      if @painter.save
        format.json { render json: @painter }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_painter
      @painter = Painter.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def painter_params
      params.require(:painter).permit(:name, :basic_pay, :daily_wage, :daily_allowance, :employment_type_id, :is_active,
        painter_contact_attributes: [:id, :address, :telephone_one, :telephone_two, :telephone_three, :painter_id],
        next_of_kin_attributes: [:id, :name, :relation, :telephone, :painter_id], skill_ids: []
      )
    end
end
