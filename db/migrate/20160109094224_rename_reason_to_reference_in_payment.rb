class RenameReasonToReferenceInPayment < ActiveRecord::Migration
  def change
  	rename_column :payments, :reason, :reference
  end
end
