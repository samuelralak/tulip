class TrackPaintersController < ApplicationController
  before_action :set_track_painter, only: [:show, :edit, :update, :destroy]

  # GET /track_painters
  # GET /track_painters.json
  def index
      track_painter_ids = TrackPainterItem.pluck(:track_painter_id)

    # @track_painters = TrackPainter.where("id NOT IN (?)", track_painter_ids)
    # query = "SELECT COUNT(*) as count, t.week_number as week_number, p.name as name FROM track_painters AS t LEFT JOIN painters AS p 
    #   ON t.painter_id = p.id GROUP BY p.name, t.week_number HAVING COUNT(*) > 1"
    # @track_painters = TrackPainter.find_by_sql(query)
    @track_painters = TrackPainter.joins(:painter).order('painters.name ASC').group_by(&:week_number)
  end

  # GET /track_painters/1
  # GET /track_painters/1.json
  def show
  end

  # GET /track_painters/new
  def new
    @track_painter = TrackPainter.new
  end

  # GET /track_painters/1/edit
  def edit
  end

  # POST /track_painters
  # POST /track_painters.json
  def create
    @track_painter = TrackPainter.new(track_painter_params)

    respond_to do |format|
      if @track_painter.save
        format.html { redirect_to @track_painter, notice: 'Track painter was successfully created.' }
        format.json { render :show, status: :created, location: @track_painter }
      else
        format.html { render :new }
        format.json { render json: @track_painter.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /track_painters/1
  # PATCH/PUT /track_painters/1.json
  def update
    respond_to do |format|
      if @track_painter.update(track_painter_params)
        format.html { redirect_to @track_painter, notice: 'Track painter was successfully updated.' }
        format.json { render :show, status: :ok, location: @track_painter }
      else
        format.html { render :edit }
        format.json { render json: @track_painter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /track_painters/1
  # DELETE /track_painters/1.json
  def destroy
    @track_painter.destroy
    respond_to do |format|
      format.html { redirect_to track_painters_url, notice: 'Track painter was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_track_painter
      @track_painter = TrackPainter.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def track_painter_params
      params[:track_painter]
    end
end
