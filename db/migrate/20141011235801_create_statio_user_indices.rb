class CreateStatioUserIndices < ActiveRecord::Migration
  def change
    create_table :statio_user_indexes do |t|
			t.references :index, :null => false
      
      t.integer :idx_blks_read, :null => false, :limit => 8
      t.integer :idx_blks_hit, :null => false, :limit => 8
      
      t.timestamp :measured_at, :null => false
    end
    
    add_index :statio_user_indexes, [:index_id, :measured_at], :unique => true
  end
end
