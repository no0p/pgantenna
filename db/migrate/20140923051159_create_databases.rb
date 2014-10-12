class CreateDatabases < ActiveRecord::Migration
  def change
    create_table :databases do |t|
			t.text :name, :null => false
      
      t.integer :connection_limit
      t.integer :frozenxid
      t.timestamps
    end
    
    execute "alter table databases alter column created_at set default now();"
    
  end
end
