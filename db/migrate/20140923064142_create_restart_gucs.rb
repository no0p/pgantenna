class CreateRestartGucs < ActiveRecord::Migration
  def change
    create_table :restart_gucs do |t|
		
			t.decimal :shared_buffers
			t.integer :max_connections
			t.integer :blk_size
			t.text    :listen_addresses
  		t.text    :wal_level
			t.integer :wal_buffers
			t.integer :max_wal_senders, :limit => 2
			t.integer :autovacuum_max_workers, :limit => 2
			t.decimal :autovacuum_freeze_max_age
			t.decimal :autovacuum_multixact_freeze_max_age
			t.integer :max_locks_per_transaction, :limit => 2
			t.integer :max_pred_locks_per_transaction, :limit => 2
			t.integer :wal_segment_size
			t.text :data_directory
			
      t.timestamp :created_at, :null => false
    end
    
    execute "alter table restart_gucs alter column created_at set default now();"
  end
end
