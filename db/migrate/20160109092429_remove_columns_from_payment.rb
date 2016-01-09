class RemoveColumnsFromPayment < ActiveRecord::Migration
  def change
  	remove_column :payments, :from, :string
  	remove_column :payments, :to, :string
  	# change_column :payments, :client_id, 'uuid USING CAST(client_id AS uuid)'
  end
end
