class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.integer :id
      t.integer :user_id
      t.string :remember_token
      t.datetime :expire_date
    end
  end
end
