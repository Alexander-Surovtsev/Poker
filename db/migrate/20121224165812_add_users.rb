class AddUsers < ActiveRecord::Migration

def change
  create_table :users do |t|
    t.integer :id
    t.string :name
    t.string :password
    t.string :salt
  end
end

  def up
  end

  def down
  end

end
