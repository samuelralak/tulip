module StatementsHelper

def attendance(painter, site)
	track_painter_items = []
	painter.track_painters.each do |tp|
		tp.track_painter_items.where(site_id: site.id).each do |tpi|
			track_painter_items << tpi
		end
	end
	track_painter_items.length
end


end
