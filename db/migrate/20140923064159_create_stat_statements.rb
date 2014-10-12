class CreateStatStatements < ActiveRecord::Migration
  def change
    create_table :stat_statements do |t|
      t.references :statement, :null => false
  
      t.integer :role_oid, :null => false
      t.integer :db_oid, :null => false
      t.integer :calls, :limit => 8, :null => false
      t.decimal :total_time, :null => false
      t.integer :rows, :limit => 8, :null => false

      t.integer :shared_blks_hit, :limit => 8, :null => false
      t.integer :shared_blks_read, :limit => 8, :null => false
      t.integer :shared_blks_dirtied, :limit => 8, :null => false
      t.integer :shared_blks_written, :limit => 8, :null => false
      t.integer :local_blks_hit, :limit => 8, :null => false
      t.integer :local_blks_read, :limit => 8, :null => false
      t.integer :local_blks_dirtied, :limit => 8, :null => false
      t.integer :local_blks_written, :limit => 8, :null => false
      t.integer :temp_blks_read, :limit => 8, :null => false
      t.integer :temp_blks_written, :limit => 8, :null => false
      t.decimal :blk_read_time, :null => false
      t.decimal :blk_write_time, :null => false

      t.timestamp :measured_at, :null => false
      t.timestamp :created_at, :null => false
    end
    execute "alter table stat_statements alter column created_at set default now();"
  end
end
