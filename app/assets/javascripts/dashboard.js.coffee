jQuery -> 
	$('#notesModal').on 'show.bs.modal', (event) -> 
		button = $(event.relatedTarget);
		track_painter_id = button.data('track')
		start_date = button.data('startdate')
		week_number = button.data('week')
		year = button.data('year')
		painter_id = button.data('painter')
		notes = button.data('notes')
		modal = $(this)
		modal.find('.modal-body input#trackId').val(track_painter_id)
		modal.find('.modal-body input#startDate').val(start_date)
		modal.find('.modal-body input#weekNumber').val(week_number)
		modal.find('.modal-body input#year').val(year)
		modal.find('.modal-body input#painterId').val(painter_id)
		modal.find('.modal-body textarea#notes').val(notes)

	$('.chosen-select').chosen
		allow_single_deselect: true
		no_results_text: 'No results matched'
		width: '200px'
	