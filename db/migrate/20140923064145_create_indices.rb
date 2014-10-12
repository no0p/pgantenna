class CreateIndices < ActiveRecord::Migration
  def change
    create_table :indices do |t|
			t.references :database, :null => false
      t.references :table
      
      t.text :schema_name, :null => false
      t.text :name, :null => false    
      t.integer :index_oid, :null => false
      
      t.text :relam
      t.integer :indnatts
      t.text    :indkey
      t.boolean :indisunique
      
      t.timestamps
    end
    add_index :indices, [:database_id, :schema_name, :name], :unique => true
    execute "alter table indices alter column created_at set default now();"
  end
end
