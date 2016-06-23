class StatementsController < ApplicationController
  def index
    @sites = Site.where('is_active = ?', true).order('name ASC')

  end

  def show
    @site = Site.find(params[:id])
    @labours = @site.track_painter_items.group_by{ |t| t.created_at.strftime('%B, %Y')} 
    @materials = @site.materials.all.order('date asc') 
    @paints = @site.paints.all 
    track_painter_ids = @site.track_painter_items.pluck(:track_painter_id)
    painter_ids = TrackPainter.where('id IN (?)', track_painter_ids).pluck(:painter_id).uniq
    @painters = Painter.where('id IN (?)', painter_ids)
    #@painters =@site.track_painter_items.pluck(:track_painter_id).inject(Hash.new(0)) { |h, e| h[e] += 1 ; h }
    @invoices = @site.invoices.order('invoice_date asc')
    @payments = @site.payments.order('payment_date asc')
  end
end
