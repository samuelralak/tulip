class DashbaordController < ApplicationController
	skip_before_filter :verify_authenticity_token, only: [:assign_site, :add_notes]
  def index
  	@painters = Painter.all
    # logger.info "####### WEEK: #{start_date.strftime("%U").to_i}"
    
  end

  def add_notes
    if params[:track_painter_id].empty?
      new_track_painter = TrackPainter.create!(notes: params[:notes], week_number: params[:week_number], 
        year: params[:year].to_i, painter_id: params[:painter_id])
    else
      track_painter = TrackPainter.find(params[:track_painter_id])
      track_painter.update_attributes!(notes: params[:notes])
    end

    respond_to do |format|
      format.html { redirect_to "/?start_date=#{params[:start_date]}" }  
    end
  end

  def assign_site
    @painter = Painter.find(params[:painter_id])
    @track_painter =  TrackPainter.where(["week_number = ? and painter_id = ?", 
      params[:week_number].to_i, params[:painter_id]]).first

    if @track_painter
      track_painter_item = @track_painter.track_painter_items.find_by(date_attended: params[:date])

      if track_painter_item
        track_painter_item.update_attributes!(site_id: params[:site_id])
      else
        @track_painter.track_painter_items.create!(
          site_id: params[:site_id], date_attended: params[:date], daily_wage: @painter.daily_wage
        )  
      end
    else
      new_track_painter = TrackPainter.create!(week_number: params[:week_number], 
        year: params[:year].to_i, painter_id: params[:painter_id])
      new_track_painter.track_painter_items.create!(
        site_id: params[:site_id], date_attended: params[:date], daily_wage: @painter.daily_wage
      )
    end

  	respond_to do |format|
      puts params[:start_date].present?
      if params[:start_date].present?
        format.html { redirect_to "/?start_date=#{params[:start_date]}" }  
      else
        format.html { redirect_to root_path }
      end
  		
  		format.json {}
  	end
  end
end
