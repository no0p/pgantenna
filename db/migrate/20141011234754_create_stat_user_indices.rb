class CreateStatUserIndices < ActiveRecord::Migration
  def change
    create_table :stat_user_indexes do |t|
			t.references :index, :null => false
      
      t.integer :idx_scan, :null => false, :limit => 8
      t.integer :idx_tup_read, :null => false, :limit => 8
      t.integer :idx_tup_fetch, :null => false, :limit => 8

      t.timestamp :measured_at, :null => false
    end
    
    add_index :stat_user_indexes, [:index_id, :measured_at], :unique => true
  end
end
