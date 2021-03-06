class DashbaordController < ApplicationController
  before_action :check_query
  before_action :set_start_date, only: [:index, :add_notes, :import_from_previous, :reset_week]
	skip_before_filter :verify_authenticity_token, only: [:assign_site, :add_notes]

  def index
    if @selected
      track_painter_ids = TrackPainterItem.where(site_id: @selected).pluck(:track_painter_id)
      painter_ids = TrackPainter.where('id in (?) AND week_number = ? AND year=?',
        track_painter_ids, @start_date.end_of_week.strftime("%U").to_i, @start_date.end_of_week.strftime("%Y").to_i)
        .pluck(:painter_id)
      @painters = Painter.where('id in (?) AND is_active = ?', painter_ids, true).
        includes(:employment_type, track_painters: :track_painter_items)
      # employment_type = EmploymentType.find(@selected)
      # @painters = employment_type.painters.where(is_active: true).order('name ASC')
    else
      @painters = Painter.where(is_active: true).
        includes(:employment_type, track_painters: :track_painter_items).
        order('name ASC')
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
    @track_painter =  TrackPainter.where(["year = ? and week_number = ? and painter_id = ?",
      (Date.parse(params[:date])).end_of_week.strftime("%Y").to_i, params[:week_number].to_i, params[:painter_id]]).first

    logger.info "PARAMS: #{params.inspect}"

    if @track_painter
      track_painter_item = @track_painter.track_painter_items.where(date_attended: params[:date])

      if !track_painter_item.length.eql?(0)
        if params[:site_id].empty?
          track_painter_item.destroy_all
          tpi_count = @track_painter.track_painter_items.count
          @track_painter.destroy if tpi_count.eql?(0)
        else
          unless track_painter_item.count.eql?(1)
            track_painter_item.destroy_all
            @track_painter.track_painter_items.create!(
              site_id: params[:site_id], date_attended: params[:date], daily_wage: @painter.daily_wage,
              daily_allowance: @painter.daily_allowance
            )
          else
            track_painter_item[0].update_attributes!(site_id: params[:site_id])
          end
        end
      else
        @track_painter.track_painter_items.create!(
          site_id: params[:site_id], date_attended: params[:date], daily_wage: @painter.daily_wage,
          daily_allowance: @painter.daily_allowance
        )
      end
    else
      new_track_painter = TrackPainter.create!(week_number: params[:week_number],
        year: params[:year].to_i, painter_id: params[:painter_id], weekly_total: 0.0)
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

  def import_from_previous
    prev_start_date = Date.parse(params[:prev_date])
    prev_date_year = prev_start_date.end_of_week.strftime("%Y").to_i
    prev_week_number = prev_start_date.end_of_week.strftime("%U").to_i
    curr_week_dates = (@start_date.beginning_of_week..@start_date.end_of_week).map { |e| Date.parse(e.to_s) }

    track_painters = TrackPainter.where(week_number: prev_week_number, year: prev_date_year)
    track_painters.each_with_index do |tp|
      new_track_painter = TrackPainter.create(
        week_number: @start_date.end_of_week.strftime("%U").to_i, year: @start_date.end_of_week.strftime("%Y").to_i,
        weekly_total: tp.weekly_total, painter_id: tp.painter_id, notes: tp.notes )
      tp.track_painter_items.each do |tpi|
        curr_week_dates.each do |d|
          if d.strftime("%A").eql?tpi.date_attended.strftime("%A")
            new_track_painter.track_painter_items.create(
              site_id: tpi.site_id, date_attended: d, daily_wage: tpi.daily_wage,
              daily_allowance: tpi.daily_allowance
            )
          end
        end
      end
    end

    render json: { message: "data successfully imported" }, status: :ok
  end

  def reset_week
    week_number = @start_date.end_of_week.strftime("%U").to_i
    year = @start_date.end_of_week.strftime("%Y").to_i

    begin
      TrackPainter.where(week_number: week_number, year: year).destroy_all

      redirect_to root_path, notice: 'successfully reset week'
    rescue StandardError => e
      flash.now[:error] = "An error occured. Please try again"
      redirect_to root_path
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
