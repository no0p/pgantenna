class CreateTables < ActiveRecord::Migration
  def change
    create_table :tables do |t|
			t.references :database, :null => false
			t.text :schema_name, :null => false
			t.text :name, :null => false
			t.integer	 :table_oid, :null => false

      t.integer :relchecks
      t.boolean :relhaspkey
      t.boolean :relhastriggers
      t.text    :relpersistence
      
      t.timestamps
    end
    
    execute "alter table tables alter column created_at set default now();"
  end
end
