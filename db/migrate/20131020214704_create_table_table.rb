class CreateTableTable < ActiveRecord::Migration
  def up
    create_table :tables do |t|
      t.integer :id
      t.string :name
    end
  end

  def down
  end
end
