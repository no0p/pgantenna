class CreateStatDatabases < ActiveRecord::Migration
  def up
    execute <<SQL
	create table stat_database (id serial primary key, database_id int not null, numbackends int not null, 
	xact_commit bigint not null, xact_rollback bigint not null, blks_read bigint not null, blks_hit bigint not null,
												 tup_returned bigint not null, tup_fetched bigint not null, tup_inserted bigint not null,
												 tup_updated bigint not null, tup_deleted bigint not null, conflicts bigint not null,
												 temp_files bigint not null, temp_bytes bigint not null, deadlocks bigint not null, 
												 blk_read_time double precision not null, blk_write_time double precision not null, 
												 stats_reset timestamptz, measured_at timestamptz not null, created_at timestamptz not null default now() );	
	
SQL
		add_index :stat_database, [:database_id, :measured_at]
  end
  
  def down
  	execute "drop table stat_database"
  end
end
