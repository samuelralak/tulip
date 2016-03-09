class TrackPainterItemsController < ApplicationController
  before_action :set_track_painter_item, only: [:show, :edit, :update, :destroy]

  # GET /track_painter_items
  # GET /track_painter_items.json
  def index
      track_painter_items = []
      TrackPainter.all.each do |t|
          if t.track_painter_items.count > 1
              t.track_painter_items.map { |tpi| track_painter_items << tpi  }
          end
      end
    @track_painter_items = track_painter_items
  end

  # GET /track_painter_items/1
  # GET /track_painter_items/1.json
  def show
  end

  # GET /track_painter_items/new
  def new
    @track_painter_item = TrackPainterItem.new
  end

  # GET /track_painter_items/1/edit
  def edit
  end

  # POST /track_painter_items
  # POST /track_painter_items.json
  def create
    @track_painter_item = TrackPainterItem.new(track_painter_item_params)

    respond_to do |format|
      if @track_painter_item.save
        format.html { redirect_to @track_painter_item, notice: 'Track painter item was successfully created.' }
        format.json { render :show, status: :created, location: @track_painter_item }
      else
        format.html { render :new }
        format.json { render json: @track_painter_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /track_painter_items/1
  # PATCH/PUT /track_painter_items/1.json
  def update
    respond_to do |format|
      if @track_painter_item.update(track_painter_item_params)
        format.html { redirect_to @track_painter_item, notice: 'Track painter item was successfully updated.' }
        format.json { render :show, status: :ok, location: @track_painter_item }
      else
        format.html { render :edit }
        format.json { render json: @track_painter_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /track_painter_items/1
  # DELETE /track_painter_items/1.json
  def destroy
    @track_painter_item.destroy
    respond_to do |format|
      format.html { redirect_to track_painter_items_url, notice: 'Track painter item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_track_painter_item
      @track_painter_item = TrackPainterItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def track_painter_item_params
      params.require(:track_painter_item).permit(:site_id, :date_attended, :daily_wage, :track_painter_id, :daily_allowance)
    end
end
