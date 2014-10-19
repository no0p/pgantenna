class CreateStatActivities < ActiveRecord::Migration
  def change
    create_table :stat_activity do |t|
			t.references :database, :null => false
			t.integer    :pid, :null => false
			t.text			 :user, :null => false
			t.text			 :application_name
			t.text			 :client_addr, :null => false
			t.text			 :state, :null => false
			t.text       :query
			t.timestamp	 :backend_start
			t.timestamp	 :query_start
			t.timestamp	 :state_change
      t.timestamp  :measured_at, :null => false
    end
  end
end
