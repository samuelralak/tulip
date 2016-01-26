class DashbaordController < ApplicationController
  before_action :check_query
  before_action :set_start_date, only: [:add_notes]
	skip_before_filter :verify_authenticity_token, only: [:assign_site, :add_notes]

  def index
    if @selected
      track_painter_ids = TrackPainterItem.where(site_id: @selected).pluck(:track_painter_id)
      painter_ids = TrackPainter.where('id in (?)', track_painter_ids).pluck(:painter_id)
      @painters = Painter.where('id in (?) AND is_active = ?', painter_ids, true)
      # employment_type = EmploymentType.find(@selected)
      # @painters = employment_type.painters.where(is_active: true).order('name ASC')
    else
      @painters = Painter.where(is_active: true).order('name ASC')
    end
    # logger.info "####### WEEK: #{start_date.strftime("%U").to_i}"
    
  end

  def add_notes
    if params[:track_painter_id].nil? || params[:track_painter_id].empty?
      new_track_painter = TrackPainter.create!(notes: params[:notes], week_number: params[:week_number], 
        year: params[:year].to_i, painter_id: params[:painter_id])
    else
      track_painter = TrackPainter.find(params[:track_painter_id])
      track_painter.update_attributes!(notes: params[:notes])
    end

    respond_to do |format|
      if params[:start_date]
        format.html { redirect_to "/?start_date=#{@start_date}" }  
      else
        format.html { redirect_to root_path }  
      end
    end
  end

  def assign_site
    @painter = Painter.find(params[:painter_id])
    @track_painter =  TrackPainter.where(["week_number = ? and painter_id = ?", 
      params[:week_number].to_i, params[:painter_id]]).first

    logger.info "PARAMS: #{params.inspect}"

    if @track_painter
      track_painter_item = @track_painter.track_painter_items.find_by(date_attended: params[:date])

      if track_painter_item
        if params[:site_id].empty?
          track_painter_item.destroy
        else
          track_painter_item.update_attributes!(site_id: params[:site_id])
        end
      else
        @track_painter.track_painter_items.create!(
          site_id: params[:site_id], date_attended: params[:date], daily_wage: @painter.daily_wage,
          daily_allowance: @painter.daily_allowance
        )  
      end
    else
      new_track_painter = TrackPainter.create!(week_number: params[:week_number], 
        year: params[:year].to_i, painter_id: params[:painter_id])
      new_track_painter.track_painter_items.create!(
        site_id: params[:site_id], date_attended: params[:date], daily_wage: @painter.daily_wage,
        daily_allowance: @painter.daily_allowance
      )
    end

  	respond_to do |format|
      # puts params[:start_date].present?
      if params[:start_date].present?
        format.html { redirect_to "/?start_date=#{params[:start_date]}&query=#{@selected}" }  
      else
        format.html { redirect_to "/?query=#{@selected}" }
      end
  		
  		format.json { render json: { data: 'success' }, status: :ok }
  	end
  end

  private
    def set_start_date
      @start_date = params[:start_date] ? Date.parse(params[:start_date]) : DateTime.now
    end

    def check_query
      if params[:query] && !params[:query].eql?('')
        @selected = params[:query]
      end
    end
end
