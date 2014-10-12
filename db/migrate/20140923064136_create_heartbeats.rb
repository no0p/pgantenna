class CreateHeartbeats < ActiveRecord::Migration
  def change
    create_table :heartbeats do |t|
			t.integer		:current_tx_id, :null => false
			t.timestamp :measured_at, :null => false
    end
    
    add_index :heartbeats, :measured_at
  end
end
