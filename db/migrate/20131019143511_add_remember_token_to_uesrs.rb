class AddRememberTokenToUesrs < ActiveRecord::Migration
  def change
    change_table :users do |t|    
      add_column :users, :remember_token, :string
      add_index :users, :remember_token
    end
  end
end