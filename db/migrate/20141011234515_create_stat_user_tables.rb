class CreateStatUserTables < ActiveRecord::Migration
  def change
    create_table :stat_user_tables do |t|
			t.references :table, :null => false
      
      t.integer :seq_scan, :null => false, :limit => 8
      t.integer :seq_tup_read, :null => false, :limit => 8
      t.integer :idx_scan, :null => false, :limit => 8
      t.integer :idx_tup_fetch, :null => false, :limit => 8
      t.integer :n_tup_ins, :null => false, :limit => 8
      t.integer :n_tup_upd, :null => false, :limit => 8
      t.integer :n_tup_del, :null => false, :limit => 8
      t.integer :n_tup_hot_upd, :null => false, :limit => 8
      t.integer :n_live_tup, :null => false, :limit => 8
      t.integer :n_dead_tup, :null => false, :limit => 8
      t.integer :vacuum_count, :null => false, :limit => 8
      t.integer :autovacuum_count, :null => false, :limit => 8
      t.integer :analyze_count, :null => false, :limit => 8
      t.integer :autoanalyze_count, :null => false, :limit => 8
      t.timestamp :last_vacuum
      t.timestamp :last_autovacuum
      t.timestamp :last_analyze
      t.timestamp :last_autoanalyze
      

      t.timestamp :measured_at, :null => false
    end
    
    add_index :stat_user_tables, [:table_id, :measured_at], :unique => true
  end
end
