class CreateStatBgwriters < ActiveRecord::Migration
  def change
    create_table :stat_bgwriter do |t|
			t.integer :checkpoints_timed, :null => false, :limit => 8
      t.integer :checkpoints_req, :null => false, :limit => 8
      t.decimal :checkpoint_write_time, :null => false
			t.decimal :checkpoint_sync_time, :null => false
			t.integer :buffers_checkpoint, :null => false, :limit => 8
			t.integer :buffers_clean, :null => false , :limit => 8
			t.integer :maxwritten_clean, :null => false, :limit => 8
			t.integer :buffers_backend, :null => false, :limit => 8
			t.integer :buffers_backend_fsync, :null => false, :limit => 8
			t.integer :buffers_alloc, :null => false, :limit => 8
			t.timestamp :stats_reset, :null => false
		  t.timestamp :measured_at, :null => false
    end
  end
end
