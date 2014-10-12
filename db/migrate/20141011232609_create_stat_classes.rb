class CreateStatClasses < ActiveRecord::Migration
  def change
    create_table :stat_class do |t|
			t.references :table
      t.references :index
      
      t.integer :relpages 
      t.integer :reltuples
      t.integer :relallvisible
      
      t.integer :rel_size_bytes # size in bytes of the relation on disk.
      t.integer :rel_indexes_size_bytes # size of indexes associated with relation, this is 0 for relations that are indexes themselves
      
      
      t.timestamp :measured_at, :null => false
    end
    
    add_index :stat_class, [:table_id, :measured_at]
    add_index :stat_class, [:index_id, :measured_at]
    
  end
end
