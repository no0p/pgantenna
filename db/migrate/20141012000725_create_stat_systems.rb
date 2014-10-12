class CreateStatSystems < ActiveRecord::Migration
  def change
    create_table :stat_systems do |t|
			t.integer :cpu_count, :null => false
			
			t.integer :page_size, :null => false
			t.integer :pages, :null => false, :limit => 8
			t.integer :pages_available, :null => false, :limit => 8
			
			t.decimal :one_min_load_avg, :null => false
			
			t.integer :swap_total, :null => false, :limit => 8 # kb
			t.integer :swap_free, :null => false, :limit => 8 # kb
			t.integer :swap_cached, :null => false, :limit => 8 # kb
			
			t.integer :page_cache, :null => false, :limit => 8 # kb
			t.integer :buffer_cache, :null => false, :limit => 8 # kb
		
      t.timestamp :measured_at, :null => false
    end
    
    execute "alter table stat_systems alter column measured_at set default now();"
  end
end
