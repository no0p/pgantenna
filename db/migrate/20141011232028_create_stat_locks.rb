class CreateStatLocks < ActiveRecord::Migration
  def change
    create_table :stat_lock do |t|
			t.references :database, :null => false 
			t.references :stat_activity, :null => false # activity associated with lock
			
			t.boolean :granted, :null => false
			t.text    :holder_vxid, :null => false # virtual transaction id of lock holder/requester
			
			t.text :lock_type, :null => false
			t.text :lock_mode, :null => false
			
		  t.references :table
			t.integer		 :relation_oid
			t.integer    :page
			t.integer    :tuple
			t.integer    :transaction_id
			t.text       :vtransaction_id
			
			t.timestamp :measured_at, :null => false
    end
  end
end
