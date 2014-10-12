class CreateStatioUserTables < ActiveRecord::Migration
  def change
    create_table :statio_user_tables do |t|
			t.references :table, :null => false
      t.integer :heap_blks_read, :null => false, :limit => 8
      t.integer :heap_blks_hit, :null => false, :limit => 8
      t.integer :idx_blks_read, :null => false, :limit => 8
      t.integer :idx_blks_hit, :null => false, :limit => 8
      t.integer :toast_blks_read, :null => false, :limit => 8
      t.integer :toast_blks_hit, :null => false, :limit => 8
      t.integer :tidx_blks_read, :null => false, :limit => 8
      t.integer :tidx_blks_hit, :null => false, :limit => 8

      t.timestamp :measured_at, :null => false
    end
    
    add_index :statio_user_tables, [:table_id, :measured_at], :unique => true
    
  end
end
