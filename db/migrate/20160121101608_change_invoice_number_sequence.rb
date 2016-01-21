class ChangeInvoiceNumberSequence < ActiveRecord::Migration
  def change
  	execute "DROP SEQUENCE IF EXISTS invoice_number"
    execute "CREATE SEQUENCE invoice_number MINVALUE 150027 START WITH 150027 INCREMENT BY 1"
  end
end
