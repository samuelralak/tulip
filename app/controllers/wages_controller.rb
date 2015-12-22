class WagesController < ApplicationController
  before_action :set_start_date
  before_action :set_permanent_painters, only: [:monthly, :painter_monthly]

  def weekly
  	@painters = Painter.where(employment_type_id: EmploymentType.find_by(code: 'TEMPORARY').id, is_active: true)
  	@track_painters = TrackPainter.where(
  		['painter_id IN (?) AND week_number = ?', @painters.pluck(:id), @start_date.strftime("%U").to_i]
  	)
  	@sites_attended = TrackPainterItem.joins(:site)
  		.includes(:track_painter)
  		.where(date_attended: @start_date.end_of_week)
  		.where('track_painter_id IN (?)', @track_painters.pluck(:id))
      .group_by{ |s| s.site.name }
  end

  def monthly
    @total = 0.0
  end

  def painter_monthly
    @painter = Painter.find(params[:painter_id])
    @track_painters = TrackPainter.where(painter_id: @painter.id)
    @sites_attended = TrackPainterItem.where('track_painter_id IN (?) AND date_attended BETWEEN ? AND ?', 
      @track_painters.pluck(:id), @start_date.beginning_of_month, @start_date.end_of_month 
    )

    # get all days excluding sundays
    @working_days = (@start_date.beginning_of_month..@start_date.end_of_month).select { |d| (1..6).include?(d.wday) }

    # get all days worked excluding sundays
    @days_worked = TrackPainterItem.where('track_painter_id IN (?) AND date_attended IN (?) AND date_attended BETWEEN ? AND ?', 
      @track_painters.pluck(:id), @working_days, @start_date.beginning_of_month, @start_date.end_of_month 
    )

    @holidays = Holiday.pluck(:date).map { |d| DateTime.parse(d) }
    @holidays_worked = @sites_attended.where('date_attended IN (?)', @holidays)
    @days_worked_final = @days_worked.where('date_attended IN (?)', @holidays)
  end

  private
    def set_start_date
      @start_date = params[:start_date] ? DateTime.parse(params[:start_date]) : DateTime.now
    end

    def set_permanent_painters
      @painters = Painter.where(employment_type_id: EmploymentType.find_by(code: 'PERMANENT').id, is_active: true)  
    end
end
