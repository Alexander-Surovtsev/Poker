class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.integer :id
      t.integer :user_id
      t.integer :money
      t.integer :games

      t.timestamps
    end
  end
end
