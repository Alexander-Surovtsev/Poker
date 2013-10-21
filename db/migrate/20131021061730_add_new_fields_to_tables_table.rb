class AddNewFieldsToTablesTable < ActiveRecord::Migration
  def change
    add_column :tables, :session_id, :integer
  end
end
