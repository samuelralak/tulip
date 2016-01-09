class Invoice < ActiveRecord::Base
	has_many :invoice_items
	accepts_nested_attributes_for :invoice_items, allow_destroy: true
	
	before_save :assign_invoice_number

	private
		def assign_invoice_number
			# This returns a PGresult object [http://rubydoc.info/github/ged/ruby-pg/master/PGresult]
      		result = Invoice.connection.execute("SELECT nextval('invoice_number')")
			self.invoice_number = result[0]['nextval']
		end
end
