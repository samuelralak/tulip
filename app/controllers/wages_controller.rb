class WagesController < ApplicationController
  before_action :check_query
  before_action :set_start_date
  before_action :set_monthly_painters, only: [:monthly, :painter_monthly]
  before_action :set_permanent_painters, only: [:permanent, :painter_permanent]

  def weekly
  	@track_painters = TrackPainter.where(['week_number = ? AND year = ?',
        @start_date.strftime("%U").to_i,
        @start_date.strftime("%Y").to_i
    ])
    @painters = Painter.where('id IN (?) AND employment_type_id = ?',
        @track_painters.pluck(:painter_id),
        EmploymentType.find_by(code: 'TEMPORARY').id
    )
  	@sites_attended = TrackPainterItem.joins(:site).includes(:track_painter)
        .where(date_attended: @start_date.end_of_week)
        .where('track_painter_id IN (?)', @track_painters.pluck(:id))
        .group_by{ |s| s.site.name }

    respond_to do |format|
      format.html {}
      format.pdf { render pdf: 'weekly' }
    end
  end

  def planning
  if @selected
      track_painter_ids = TrackPainterItem.where(site_id: @selected).pluck(:track_painter_id)
      painter_ids = TrackPainter.where(
        'id in (?) AND week_number = ? AND year=?',
        track_painter_ids, @start_date.strftime("%U").to_i, @start_date.strftime("%Y").to_i)
        .pluck(:painter_id)
      @painters = Painter.where('id in (?) AND is_active = ?', painter_ids, true)

    else
      @painters = Painter.where(is_active: true).order('name ASC')
    end
  end


  def costing
  	@painters = Painter.all
  	@track_painters = TrackPainter.where(
  		['painter_id IN (?) AND week_number = ?', @painters.pluck(:id), @start_date.strftime("%U").to_i]
  	)
    @painters = @painters.where('id IN (?)', @track_painters.pluck(:painter_id))
  	@sites_attended = TrackPainterItem.joins(:site)
  		.where('date_attended BETWEEN ? AND ?', @start_date.beginning_of_week, @start_date.end_of_week)
  		.where('track_painter_id IN (?)', @track_painters.pluck(:id))
      .group_by{ |s| s.site.name }

    respond_to do |format|
      format.html {}
      format.pdf { render pdf: 'costing' }
    end
  end


  def permanent
    @total = 0.0

    respond_to do |format|
      format.html {}
      format.pdf { render pdf: 'permanent' }
    end
  end

  def painter_permanent
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

    respond_to do |format|
      format.html {}
      format.pdf { render pdf: 'permanent' }
    end
  end

  def monthly
    @total = 0.0

    respond_to do |format|
      format.html {}
      format.pdf { render pdf: 'monthly' }
    end
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

    respond_to do |format|
      format.html {}
      format.pdf { render pdf: 'painter_monthly' }
    end
  end

  private
    def set_start_date
      @start_date = params[:start_date] ? DateTime.parse(params[:start_date]) : DateTime.now
    end
    def check_query
      if params[:query] && !params[:query].eql?('')
        @selected = params[:query]
      end
    end
    def set_monthly_painters
      @painters = Painter.where('employment_type_id = ?', EmploymentType.find_by(code: 'MONTHLY').id)
    end

    def set_permanent_painters
      @painters = Painter.where('employment_type_id = ?', EmploymentType.find_by(code: 'PERMANENT').id)
    end
end
