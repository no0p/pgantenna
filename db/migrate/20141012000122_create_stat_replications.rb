class CreateStatReplications < ActiveRecord::Migration
  def change
    create_table :stat_replication do |t|
			t.text :usename, :null => false
      t.text :application_name
      t.text :client_addr, :null => false
      t.text :client_hostname, :null 
      t.text :client_port, :null => false
      t.timestamp :backend_start, :null => false
      t.text :state, :null => false
      t.text :sent_location, :null => false
      t.text :write_location, :null => false
      t.text :flush_location, :null => false
      t.text :replay_location, :null => false
      t.text :sync_priority, :null => false
      t.text :sync_state, :null => false
      
      t.text :current_xlog, :null => false
      
      t.timestamp :measured_at, :null => false
    end
  end
end
