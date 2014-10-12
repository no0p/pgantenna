class Antenna
  module Commands

	  ARG_DELIMITER = "\x1F"
	  ARG_GROUP_DELIMITER = "\x1E"

    #
    # This is a startup thing to establish a unique token for the server.
    #   Once the response is sent verifying availability, then the 
    #     token identifies future requests
    #
    def handshake(data)
      @token, @pg_version = data.split(ARG_DELIMITER)
      return "OK+"
    end
    
    #
    # This is a request used to identify that the server is up.
    #
	  def heartbeat(data)
	    
		  tx_id, measured_at = data.split(/#{ARG_DELIMITER}/, -1)
	    
	    # Log heartbeat
	    Heartbeat.create(
	    	:current_tx_id => tx_id,
	    	:measured_at => measured_at
	    )
	    return "OK+"
	  end
	
	  #
	  # Update gucs. PRMGUC
	  #
	  def restart_gucs(data)

		  shared_bufs, max_connections, wal_level, blk_size, listen_addresses, wal_buffers, max_wal_senders, autovacuum_max_workers, autovacuum_freeze_max_age, autovacuum_multixact_freeze_max_age, max_locks_per_transaction, max_pred_locks_per_transaction, wal_segment_size, data_directory = data.split(/#{ARG_DELIMITER}/, -1)
		
		
		  RestartGuc.create(
			  :shared_buffers => shared_bufs,
			  :max_connections => max_connections,
			  :wal_level => wal_level,
			  :blk_size => blk_size.to_i,
			  :listen_addresses => listen_addresses, 
			  :wal_buffers => wal_buffers, 
			  :max_wal_senders => max_wal_senders, 
			  :autovacuum_max_workers => autovacuum_max_workers, 
			  :autovacuum_freeze_max_age => autovacuum_freeze_max_age, 
			  :autovacuum_multixact_freeze_max_age => autovacuum_multixact_freeze_max_age, 
			  :max_locks_per_transaction => max_locks_per_transaction, 
			  :max_pred_locks_per_transaction => max_pred_locks_per_transaction,
			  :wal_segment_size => wal_segment_size,
			  :data_directory => data_directory
		  )
		  return "OK+"
	  end
	
	  def transient_gucs(data)
	    check_seg, check_time, check_comp_target, work_mem, temp_buf, maint_work_mem, seq_page_cost, rand_page_cost, cpu_tup_cost, cpu_op_cost, effective_cache, vacuum_cost_delay, vacuum_cost_page_hit, vacuum_cost_page_miss, vacuum_cost_page_dirty, vacuum_cost_limit, bgwriter_delay, bgwriter_lru_maxpages, bgwriter_lru_multiplier, effective_io_concurrency, synchronous_commit, wal_writer_delay, commit_delay, commit_siblings, wal_keep_segments, geqo, geqo_threshold, geqo_effort, geqo_pool_size, geqo_generations, geqo_selection_bias, geqo_seed, default_statistics_target, constraint_exclusion, cursor_tuple_fraction, from_collapse_limit, join_collapse_limit, autovacuum, autovacuum_vacuum_threshold, autovacuum_analyze_threshold, autovacuum_scale_factor, autovacuum_analyze_scale_factor, autovacuum_cacuum_cost_delay, deadlock_timeout  = data.split(/#{ARG_DELIMITER}/, -1)
		
		  TransientGuc.create(
			  :checkpoint_segments => check_seg, 
			  :checkpoint_timeout => check_time, 
			  :checkpoint_completion_target => check_comp_target, 
			  :work_mem => work_mem, 
			  :temp_buffers => temp_buf, 
			  :maintenance_work_mem => maint_work_mem, 
			  :seq_page_cost => seq_page_cost, 
			  :random_page_cost => rand_page_cost, 
			  :cpu_tuple_cost => cpu_tup_cost, 
			  :cpu_operator_cost => cpu_op_cost, 
			  :effective_cache_size => effective_cache, 
			  :vacuum_cost_delay => vacuum_cost_delay, 
			  :vacuum_cost_page_hit => vacuum_cost_page_hit, 
			  :vacuum_cost_page_miss => vacuum_cost_page_miss, 
			  :vacuum_cost_page_dirty => vacuum_cost_page_dirty, 
			  :vacuum_cost_limit => vacuum_cost_limit, 
			  :bgwriter_delay => bgwriter_delay, 
			  :bgwriter_lru_maxpages => bgwriter_lru_maxpages, 
			  :bgwriter_lru_multiplier => bgwriter_lru_multiplier, 
			  :effective_io_concurrency => effective_io_concurrency, 
			  :synchronous_commit => synchronous_commit, 
			  :wal_writer_delay => wal_writer_delay, 
			  :commit_delay => commit_delay, 
			  :commit_siblings => commit_siblings, 
			  :wal_keep_segments => wal_keep_segments, 
			  :geqo => geqo, 
			  :geqo_threshold => geqo_threshold, 
			  :geqo_effort => geqo_effort, 
			  :geqo_pool_size => geqo_pool_size, 
			  :geqo_generations => geqo_generations, 
			  :geqo_selection_bias => geqo_selection_bias, 
			  :geqo_seed => geqo_seed, 
			  :default_statistics_target => default_statistics_target, 
			  :constraint_exclusion => constraint_exclusion, 
			  :cursor_tuple_fraction => cursor_tuple_fraction, 
			  :from_collapse_limit => from_collapse_limit, 
			  :join_collapse_limit => join_collapse_limit, 
			  :autovacuum => autovacuum, 
			  :autovacuum_vacuum_threshold => autovacuum_vacuum_threshold, 
			  :autovacuum_analyze_threshold => autovacuum_analyze_threshold, 
			  :autovacuum_scale_factor => autovacuum_scale_factor, 
			  :autovacuum_analyze_scale_factor => autovacuum_analyze_scale_factor, 
			  :autovacuum_vacuum_cost_delay => autovacuum_cacuum_cost_delay, 
			  :deadlock_timeout => deadlock_timeout
		  )
		
		  return "OK+"
	  end

	
	  #
	  # Data contains information about databases, outlining databases -> schemas -> tables -> columns
	  # COLNFO
	  #
	  def column_info(data)
		  data.split(ARG_GROUP_DELIMITER).each do |r|
			  database_name, schema_name, table_name, column_name, data_type_name, table_oid, attnotnull, attstattarget, attnum = r.split(/#{ARG_DELIMITER}/, -1)
			
			  database_id = get_database_id(database_name)
			  table_id = get_table_id(database_id, schema_name, table_name, table_oid)
			
			  begin
			
			    column = Column.where(:table_id => table_id, :name => column_name).first
			    
			    if column.nil?
			      # create a new record for this column
    				Column.create(:table_id => table_id, 
				                      :name => column_name, 
				                      :data_type => data_type_name,
				                      :attstattarget => attstattarget,
				                      :attnotnull => attnotnull,
				                      :attnum => attnum)
			    else
			      # update attributes if changed
			      if (column.data_type != data_type_name || column.attnotnull != attnotnull || column.attnum != attnum)
			        Column.where(:table_id => table_id, :name => column_name).update_attributes(:attnotnull => attnotnull, :attnum => attnum, :data_type => data_type_name)
			      end
			    end
			  rescue ActiveRecord::RecordNotUnique => e
				  #Swallow
			  end		
		
			  # create or replace column_name, if different add new record with timestamps to save type changes?
		  end
		  return "OK+"
	  end
	
	  #
	  # RELNFO
    #
	  def relation_info(data)
	    data.split(ARG_GROUP_DELIMITER).each do |r|
			   database_name, schema_name, relname, reloid, relkind, relpersistence, relam, relpages, reltuples, relallvisible, relchecks, relhaspkey, relhastriggers, rel_size, rel_index_size, measured_at = r.split(/#{ARG_DELIMITER}/, -1)
			
			  database_id = get_database_id(database_name)
			
			  if relkind == "r" # table relations
			    table_id = get_table_id(database_id, schema_name, relname, reloid)
			    Table.find(table_id).update_attributes(:relpersistence => relpersistence,
			                       :relchecks => relchecks,
			                       :relhaspkey => relhaspkey,
			                       :relhastriggers => relhastriggers)
			    
			    StatClass.create(:table_id => table_id, :reltuples => reltuples,
			                            :relpages => relpages, :relallvisible => relallvisible,
			                            :rel_size_bytes => rel_size, :rel_indexes_size_bytes => rel_index_size,
			                            :measured_at => measured_at)
			                  
			  elsif relkind == "i" #index relations
			    index_id = get_index_id(database_id, schema_name, relname, reloid)
			    Index.find(index_id).update_attributes(:relam => relam)
			    
			    StatClass.create(:index_id => index_id, :reltuples => reltuples,
			                            :relpages => relpages, :relallvisible => relallvisible,
			                            :rel_size_bytes => rel_size,
			                            :measured_at => measured_at)
			    
			  else
			    # Skip as a current untrack relation type.
			    # r = ordinary table, i = index, S = sequence, v = view, 
			    # m = materialized view, c = composite type, t = TOAST table, f = foreign table
			  end
		  end
		  return "OK+"
	  end
	
	  #
	  # INDNFO -- basic info on an index.
	  #
	  def index_info(data)
	    data.split(ARG_GROUP_DELIMITER).each do |r|
			  database_name, indexrelid, tableoid, indnatts, indkey, indisunique = r.split(/#{ARG_DELIMITER}/, -1)
			
			  database_id = get_database_id(database_name)
			  table = Table.where('database_id = ? and table_oid = ?', database_id, tableoid).first
		    table_id = nil
		    table_id = table.id if !table.nil?
		    
			  Index.where('database_id = ? and index_oid = ?',database_id, indexrelid).update(:indnatts => indnatts, :indkey => indkey, :indisunique => indisunique, :table_id => table_id)
	
		  end
		  return "OK+"
	  end
	
	  #
	  # Just a list of databases in the system and some trivial data about them
	  #
	  def dblist(data)
		  data.chop! # Remove trailing group delimiter
		  data.split(ARG_GROUP_DELIMITER).each do |r|
			  database_name, connection_limit, frozenxid = r.split(/#{ARG_DELIMITER}/, -1)
			
			  begin
			    db = Database.where(:name => database_name).first
			    if db.nil?
    			  Database.create(:name => database_name, :connection_limit => connection_limit, :frozenxid => frozenxid)
    			else
    			  db.update_attributes(:connection_limit => connection_limit, :frozenxid => frozenxid)
    			end
			  rescue ActiveRecord::RecordNotUnique => e
        	# Update existing record
			  end
		  end
		
		  return "OK+"
		
	  end
	
	
	  #
	  # STSTMT -- pg_stat_statements data
	  #
	  def stat_statements(data)
	    begin
	    data.chop! # Remove trailing group delimiter
		  data.split(ARG_GROUP_DELIMITER).each do |r|
			  userid, dbid, query, calls, total_time, rows, shared_blks_hit, shared_blks_read, shared_blks_dirtied, shared_blks_written, local_blks_hit, local_blks_read, local_blks_dirtied, local_blks_written, temp_blks_read, temp_blks_written, blk_read_time, blk_write_time, measured_at = r.split(/#{ARG_DELIMITER}/, -1)
			
			  statement_id = get_statement_id(query)
						
			  if !statement_id.nil?
			    begin
				    StatStatement.create(:statement_id => statement_id,
				                             :role_oid => userid,
				                             :db_oid => dbid,
				                             :calls => calls,
				                             :total_time => total_time,
				                             :rows => rows,
				                             :shared_blks_hit => shared_blks_hit,
				                             :shared_blks_read => shared_blks_read,
				                             :shared_blks_dirtied => shared_blks_dirtied,
				                             :shared_blks_written => shared_blks_written,
				                             :local_blks_hit => local_blks_hit,
				                             :local_blks_read => local_blks_read,
				                             :local_blks_dirtied => local_blks_dirtied,
				                             :local_blks_written => local_blks_written,
				                             :temp_blks_read => temp_blks_read,
				                             :temp_blks_written => temp_blks_written,
				                             :blk_read_time => blk_read_time,
				                             :blk_write_time => blk_write_time,
				                             :measured_at => measured_at)
				                             
			    rescue ActiveRecord::RecordNotUnique => e
          	# Swallow
			    end
			  end
	    end
	    rescue Exception => e
	      puts e.to_s
	      puts e.backtrace.to_a.join("\n")
	    end
	    
	    return "OK+"
	  end
	
	  #
	  # COLSTA
	  # 
	  def column_stats(data)
	    data.chop! # Remove trailing group delimiter
		  data.split(ARG_GROUP_DELIMITER).each do |r|
			  database_name, schema_name, table_name, column_name, null_frac, avg_width, n_distinct, most_common_vals, most_common_freqs, correlation, measured_at = r.split(/#{ARG_DELIMITER}/, -1)
			
			  db_id = get_database_id(database_name)
			  table_id = get_table_id(db_id, schema_name, table_name)
			  column = Column.where(:table_id => table_id, :name => column_name).first
			  
			  if column.present?
			    begin
			      
			      avg_width = nil if avg_width.empty?
			      null_frac = nil if null_frac.empty?
			      n_distinct = nil if n_distinct.empty?
			      correlation = nil if correlation.empty?
			    
				    StatColumn.create(:column_id => column.id,
				                             :null_fraction => null_frac,
				                             :average_width_bytes => avg_width,
				                             :distinct_non_nulls => n_distinct,
				                             :most_common_vals => most_common_vals,
				                             :most_common_freqs => most_common_freqs,
				                             :correlation => correlation,
				                             :measured_at => measured_at)
			    rescue ActiveRecord::RecordNotUnique => e
          	# Update existing record
			    end
			  end
		  end
		
		  return "OK+"
	  end
	

	  #
	  # STAACT
	  #
	  def stat_activity(data)

		  data.chop! # Remove trailing group delimiter
		
		  pid_to_model_id = {} # This creates lock and activity records; there can be many locks to activities, and they are joined for efficiency.
		
		
		  data.split(ARG_GROUP_DELIMITER).each do |r|
			  datname, pid, usename, client_addr, backend_start, query_start, state, state_change, application_name, query, lock_type, lock_mode, lock_relation, lock_page, lock_tuple, lock_vxid, lock_txid, lock_granted, lock_holder_vxid, measured_at = r.split(/#{ARG_DELIMITER}/, -1)
		    
		    # Timestamp to nil rather than empty string  	
			  query_start = nil if (query_start.nil? || query_start.empty?)
			  backend_start = nil if (backend_start.nil? || backend_start.empty?)

			  begin
				  db_id = get_database_id(datname)
				
			
			    if !pid_to_model_id.keys.include? pid
				    sa = StatActivity.create(:database_id => db_id, :pid => pid.to_i, :user => usename, 
				                           :client_addr => client_addr, :backend_start => backend_start,
				                           :query_start => query_start,
				                           :state => state, :state_change => state_change, 
				                           :application_name => application_name, 
				                           :query => query, :measured_at => measured_at)
				    
				    pid_to_model_id[pid] = sa.id
				  end
				
				  #  virtualtransaction IS DISTINCT FROM virtualxid  Consider excluding these self-locks by comparing here.
				  if !lock_holder_vxid.nil? && !lock_holder_vxid.empty?

            table_id = nil
				    if !lock_relation.nil? && !lock_relation.empty?
					    table = Table.where(:database_id => db_id, :table_oid => lock_relation).first
					    table_id = table.id unless (table.nil? || table.empty?)
				    end
				
				    lock_page = nil if lock_page.nil? || lock_page.empty?
				    lock_tuple = nil if lock_tuple.nil? || lock_tuple.empty?
				    lock_txid = nil if lock_txid.nil? || lock_txid.empty?
				    lock_relation = nil if lock_relation.nil? || lock_relation.empty?
				    lock_granted = (lock_granted == "true")
				
				    StatLock.create(:database_id => db_id, :table_id => table_id,
				                          :stat_activity_id => pid_to_model_id[pid],
															    :relation_oid => lock_relation, :lock_type => lock_type, 
															    :lock_mode => lock_mode,
															    :page => lock_page, :tuple => lock_tuple, 
														      :transaction_id => lock_txid, :vtransaction_id => lock_vxid,
															    :holder_vxid => lock_holder_vxid, :granted => lock_granted,
															    :measured_at => measured_at)
		      end


			  rescue ActiveRecord::RecordNotUnique => e
        	# puts "unique constraint skip"
			  end
		  end
		
		  return "OK+"
	  end
	
	  #
	  # DBSTAT
	  #
	  def db_stats(data) 
	    data.chop! # Remove trailing group delimiter
		  data.split(ARG_GROUP_DELIMITER).each do |r|
			   datname, numbackends, xact_commit, xact_rollback, blks_read, blks_hit, tup_returned, tup_fetched, tup_inserted, tup_deleted, tup_updated, conflicts, temp_files, temp_bytes, deadlocks, blk_read_time, blk_write_time, stats_reset, measured_at = r.split(/#{ARG_DELIMITER}/, -1)
			   
			  stats_reset = nil if stats_reset.empty?
			   
			  begin

				  StatDatabase.create(:database_id => get_database_id(datname), 
				                       :numbackends => numbackends.to_i, :xact_commit => xact_commit.to_i,
				                       :xact_rollback => xact_rollback.to_i, :blks_read => blks_read.to_i, 
				                       :blks_hit => blks_hit.to_i,
				                       :tup_returned => tup_returned.to_i, :tup_fetched => tup_fetched.to_i, 
				                       :tup_inserted => tup_inserted.to_i, :tup_deleted => tup_deleted.to_i,
				                       :tup_updated => tup_updated.to_i,
				                       :conflicts => conflicts.to_i,
				                       :temp_files => temp_files.to_i, :temp_bytes => temp_bytes.to_i, 
				                       :deadlocks => deadlocks.to_i,
				                       :blk_read_time => blk_read_time.to_f, :blk_write_time => blk_write_time.to_f, 
				                       :stats_reset => stats_reset, :measured_at => measured_at)

			  rescue ActiveRecord::RecordNotUnique => e
        	# puts "unique constraint skip"
			  end
		  end
	    
	    return "OK+"
	    
	  end
	
	  #
	  #
	  #
	  def table_stats(data)
	    data.chop! # Remove trailing group delimiter
		  data.split(ARG_GROUP_DELIMITER).each do |r|
		    db_name, schemaname, relname, relid, seq_scan, seq_tup_read, idx_scan, idx_tup_fetch, n_tup_ins, n_tup_upd, n_tup_del, n_tup_hot_upd, n_live_tup, n_dead_tup, last_vacuum, last_autovacuum, last_analyze, last_autoanalyze, vacuum_count, autovacuum_count, analyze_count, autoanalyze_count, measured_at = r.split(/#{ARG_DELIMITER}/, -1)
		
		    last_vacuum = nil if last_vacuum.empty?
		    last_autovacuum = nil if last_autovacuum.empty?
		    last_analyze = nil if last_analyze.empty?
		    last_autoanalyze = nil if last_autoanalyze.empty?
		
			  begin
			    database_id = get_database_id(db_name)
			    table_id = get_table_id(database_id, schemaname, relname, relid)
			    StatUserTable.create(:table_id => table_id, :seq_scan => seq_scan.to_i, 
			                            :seq_tup_read => seq_tup_read.to_i,
			                            :idx_scan => idx_scan.to_i, 
			                            :idx_tup_fetch => idx_tup_fetch.to_i, :n_tup_ins => n_tup_ins.to_i,
			                            :n_tup_upd => n_tup_upd.to_i, :n_tup_del => n_tup_del.to_i,
			                            :n_tup_hot_upd => n_tup_hot_upd.to_i, :n_live_tup => n_live_tup.to_i, 
			                            :n_dead_tup => n_dead_tup.to_i, :last_vacuum => last_vacuum, 
			                            :last_autovacuum => last_autovacuum, :last_analyze => last_analyze,
			                            :last_autoanalyze => last_autoanalyze, :vacuum_count => vacuum_count.to_i,
			                            :autovacuum_count => autovacuum_count.to_i, :analyze_count => analyze_count.to_i,
			                            :autoanalyze_count => autoanalyze_count.to_i, :measured_at => measured_at) 
			  rescue ActiveRecord::RecordNotUnique => e
        	# puts "unique constraint skip"
			  end
		  end
		
		  return "OK+"
	  end
	
	  #
	  #
	  #
	  def index_stats(data)
	    data.chop! # Remove trailing group delimiter
		  data.split(ARG_GROUP_DELIMITER).each do |r|
			  db_name, schemaname, name, indexrelid, idx_scan, idx_tup_read, idx_tup_fetch, measured_at = r.split(/#{ARG_DELIMITER}/, -1)
			  database_id = get_database_id(db_name)
			  index_id = get_index_id(database_id, schemaname, name, indexrelid)
			  begin
			    StatUserIndex.create(:index_id => index_id, :idx_scan => idx_scan.to_i, 
			                            :idx_tup_read => idx_tup_read.to_i,
			                            :idx_tup_fetch => idx_tup_fetch.to_i, :measured_at => measured_at)
			  rescue ActiveRecord::RecordNotUnique => e
        	# puts "unique constraint skip"
			  end
		  end
		
		  return "OK+"
	  end
	
	  #
	  #
	  #
	  def table_io_stats(data)
	    data.chop! # Remove trailing group delimiter
		  data.split(ARG_GROUP_DELIMITER).each do |r|
			  db_name, schemaname, relname, relid, heap_blks_read, heap_blks_hit, idx_blks_read, idx_blks_hit, toast_blks_read, toast_blks_hit, tidx_blks_read, tidx_blks_hit, measured_at = r.split(/#{ARG_DELIMITER}/, -1)
			  begin
			    database_id = get_database_id(db_name)
			    table_id = get_table_id(database_id, schemaname, relname, relid)
			    StatioUserTable.create(:table_id => table_id, :heap_blks_read => heap_blks_read.to_i,
					                      :heap_blks_hit => heap_blks_hit.to_i, :idx_blks_read => idx_blks_read.to_i,
					                      :idx_blks_hit => idx_blks_hit.to_i, :toast_blks_read => toast_blks_read.to_i,
					                      :toast_blks_hit => toast_blks_hit.to_i, :tidx_blks_read => tidx_blks_read.to_i,
					                      :tidx_blks_hit => tidx_blks_hit.to_i, :measured_at => measured_at)
			  rescue ActiveRecord::RecordNotUnique => e
        	# puts "unique constraint skip"
			  end
		  end
		
		  return "OK+"
	  end
	
	  #
	  #
	  #
	  def index_io_stats(data)
	    data.chop! # Remove trailing group delimiter
		  data.split(ARG_GROUP_DELIMITER).each do |r|
			  db_name, schemaname, name, indexrelid, idx_blks_read, idx_blks_hit, measured_at = r.split(/#{ARG_DELIMITER}/, -1)
			  database_id = get_database_id(db_name)
			  index_id = get_index_id(database_id, schemaname, name, indexrelid)
			  begin
			    StatioUserIndex.create(:index_id => index_id, :idx_blks_read => idx_blks_read.to_i,
			                               :idx_blks_hit => idx_blks_hit.to_i, :measured_at => measured_at)
			  rescue ActiveRecord::RecordNotUnique => e
        	# puts "unique constraint skip"
			  end
		  end
		
		  return "OK+"
	  end
	
	  #
	  #
	  #
	  def function_stats(data)
	    data.chop! # Remove trailing group delimiter
		  data.split(ARG_GROUP_DELIMITER).each do |r|
			  db_name, funcoid, schemaname, funcname, calls, total_time, self_time, measured_at = r.split(/#{ARG_DELIMITER}/, -1)
			
			  database_id = get_database_id(db_name)
			  function_id = get_function_id(database_id, schemaname, funcname, funcoid)
			  begin
			    StatUserFunction.create(:function_id => function_id,
			                               :calls => calls, :total_time => total_time,
			                               :self_time => self_time, :measured_at => measured_at)
			  rescue ActiveRecord::RecordNotUnique => e
        	# puts "unique constraint skip"
			  end
		  end
		
		  return "OK+"
	  end
	
	  #
	  # Replication statistics from server replicant RPSTAT
	  #
	  def replication_stats(data)
	    data.chop! # Remove trailing group delimiter
		  data.split(ARG_GROUP_DELIMITER).each do |r|
			  usename, application_name, client_addr, client_hostname, client_port, backend_start, state, sent_location, write_location, flush_location, replay_location, sync_priority, sync_state, current_xlog, measured_at = r.split(/#{ARG_DELIMITER}/, -1)
			  begin
			    StatReplication.create(:usename => usename,
									  :application_name => application_name, :client_addr => client_addr,
									  :client_hostname => client_hostname, :client_port => client_port,
									  :backend_start => backend_start, :state => state, :sent_location => sent_location,
									  :write_location => write_location, :flush_location => flush_location,
									  :replay_location => replay_location, :sync_priority => sync_priority,
									  :sync_state => sync_state, :current_xlog => current_xlog, :measured_at => measured_at)
			  rescue ActiveRecord::RecordNotUnique => e
        	# puts "unique constraint skip"
			  end
		  end
		
		  return "OK+"
	  end
	
	  #
	  #
	  #
	  def bg_writer_stats(data)
	    data.chop! # Remove trailing group delimiter
		  data.split(ARG_GROUP_DELIMITER).each do |r|
		  checkpoints_timed, checkpoints_req, checkpoint_write_time, checkpoint_sync_time, buffers_checkpoint, buffers_clean, maxwritten_clean, buffers_backend, buffers_backend_fsync, buffers_alloc, stats_reset, measured_at = r.split(/#{ARG_DELIMITER}/, -1)
			  begin
			    StatBgwriter.create(:checkpoints_timed => checkpoints_timed, 
			      :checkpoints_req => checkpoints_req,
			      :checkpoint_write_time => checkpoint_write_time, 
			      :checkpoint_sync_time => checkpoint_sync_time,
			      :buffers_checkpoint => buffers_checkpoint, :buffers_clean => buffers_clean,
			      :maxwritten_clean => maxwritten_clean, :buffers_backend => buffers_backend,
			      :buffers_backend_fsync => buffers_backend_fsync,
			      :buffers_alloc => buffers_alloc, :stats_reset => stats_reset,
			      :measured_at => measured_at)
			  rescue ActiveRecord::RecordNotUnique => e
        	# puts "unique constraint skip"
			  end
		  end
		
		  return "OK+"
	  end
	
	  #
	  # A bunch of data about the underlying system SYSNFO
	  #
	  def sys_info(data)
		  page_size, pages, pages_available, cpus, load_avg, swap_total, swap_free, swap_cached, buffer_cache, page_cache = data.split(/#{ARG_DELIMITER}/, -1)
			   
		  begin
			  StatSystem.create(:pages => pages, :page_size => page_size, 
														  :pages_available => pages_available, 
														  :cpu_count => cpus,
														  :one_min_load_avg => load_avg,
														  :swap_total => swap_total.to_i,
														  :swap_free => swap_free.to_i, 
														  :swap_cached => swap_cached.to_i,
														  :buffer_cache => buffer_cache.to_i,
														  :page_cache => page_cache.to_i,
														  :measured_at => Time.now) #TODO
		  rescue ActiveRecord::RecordNotUnique => e
      	# puts "unique constraint skip"
		  end
		
		  return "OK+"
	  end
	
	  def fs_info(data)
	    data.chop! # Remove trailing group delimiter
		  data.split(ARG_GROUP_DELIMITER).each do |r|
			  fsname, mntdir, mnt_type, mnt_opts, blksize, fragsize, blks_in_frags, blk_free, blk_avail = r.split(/#{ARG_DELIMITER}/, -1)
			  begin
			    fs_id = get_filesystem_id(fsname, mntdir, mnt_type, mnt_opts, blksize, fragsize)
			    StatFilesystem.create(:filesystem_id => fs_id, :blks_in_frags => blks_in_frags, :blk_free => blk_free, :blk_avail => blk_avail, 
			         :measured_at => Time.now) # TODO
			  rescue ActiveRecord::RecordNotUnique => e
        	# puts "unique constraint skip"
			  end
		  end
		
	    return "OK+"
	  end
	
	
	  #
	  # Generic Error Handling for malformed command
	  #
	  def unknown_command(command, data)
	    LOG.error "UNKNOWN COMMAND: #{command}"
	    return "OK-"
	  end
	
	  #
    # Extract the command type from the message and the data string
	  #
	  def parse_command(message)
		  command = message[0..5] # fixed length command
		  data = message[7..-1].strip # was -3 skip semicolon, remove whitespace at end.  might remove semicolong someday
		  return command, data
	  end
	
	  #
	  # Takes a database name and returns a db sequel record.  Creates it if it does not exist.
	  #
	  def get_database_id(db_name)
		  db = Database.where(:name => db_name).first
		  db = Database.create(:name => db_name) if db.blank?
		  return db.id
	  end
	
	
	  #
	  # A version of find or create like get_database_id above but for tables
	  #
	  def get_table_id(database_id, schema_name, table_name, table_oid = nil)
		  table_oid = nil if (table_oid.nil? || table_oid.empty?)
		  table = Table.where(:database_id => database_id, :schema_name => schema_name, :name => table_name).first
		  table = Table.create(:database_id => database_id, :schema_name => schema_name, :name => table_name, :table_oid => table_oid) if table.blank?
		  
		  return table.id
	  end
	
	 	
	  #
	  # A version of find or create like get_database_id above but for indexes
	  #
	  def get_index_id(database_id, schema_name, index_name, index_oid)
		  index_oid = nil if (index_oid.nil? || index_oid.empty?)
		  index = Index.where(:database_id => database_id, :schema_name => schema_name, :name => index_name).first
		  index = Index.create(:database_id => database_id, :schema_name => schema_name, :name => index_name, :index_oid => index_oid) if index.blank?

		  return index.id
	  end
	
	  #
	  def get_function_id(database_id, schema_name, func_name, funcoid)
		  funcoid = nil if funcoid.blank?
		  function = Function.where(:database_id => database_id, :schema_name => schema_name, :name => func_name).first
			function = Function.create(:database_id => database_id, :schema_name => schema_name, :name => func_name, :funcoid => funcoid) if function.blank?
		  return function.id
	  end
	
	  #
	  def get_filesystem_id(name, mntdir, mnt_type, mnt_opts, blksize, fragsize)

		  filesystem = Filesystem.where(:name => name, :mnt_dir => mntdir,
		                                :mnt_type => mnt_type, :mnt_opts => mnt_opts, 
		                                :blksize => blksize, :fragsize => fragsize).first

		  filesystem = Filesystem.create(:name => name, :mnt_dir => mntdir,
		                            :mnt_type => mnt_type, :mnt_opts => mnt_opts,
		                            :blksize => blksize, :fragsize => fragsize) if filesystem.blank?
		                            
		  return filesystem.id
	  end
	
	  #
	  # Find of create a statement record, return the id
	  #
	  def get_statement_id(query) 
	    qhash = Digest::MD5.hexdigest(query)

	    statement = Statement.where(:query_hash => qhash).first
      statement = Statement.create(:q => query, :query_hash => qhash) if statement.blank?

	    return statement.id
	  end
	
  end
end
