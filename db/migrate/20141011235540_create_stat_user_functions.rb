class CreateStatUserFunctions < ActiveRecord::Migration
  def change
    create_table :stat_user_functions do |t|
			t.references :function, :null => false
       
      t.integer :calls, :null => false, :limit => 8
      t.decimal :total_time, :null => false
      t.decimal :self_time, :null => false
      
      t.timestamp :measured_at, :null => false
    end
    add_index :stat_user_functions, [:function_id, :measured_at], :unique => true
  end
end
