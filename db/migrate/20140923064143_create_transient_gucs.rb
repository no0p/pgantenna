class CreateTransientGucs < ActiveRecord::Migration
  def change
    create_table :transient_gucs do |t|
			t.integer :checkpoint_segments, :limit => 2
			t.integer :checkpoint_timeout #seconds
			t.decimal :checkpoint_completion_target
      t.integer	:work_mem
      t.integer :temp_buffers
      t.integer	:maintenance_work_mem
      t.decimal :seq_page_cost
      t.decimal :random_page_cost
      t.decimal :cpu_tuple_cost
      t.decimal :cpu_operator_cost
      t.integer :effective_cache_size
      
      t.integer :vacuum_cost_delay
      t.integer :vacuum_cost_page_hit
      t.integer :vacuum_cost_page_miss
      t.integer :vacuum_cost_page_dirty
      t.integer :vacuum_cost_limit
      
      t.text    :bgwriter_delay, :limit => 2
      t.integer :bgwriter_lru_maxpages, :limit => 2
      t.decimal :bgwriter_lru_multiplier
      
      t.integer :effective_io_concurrency, :limit => 2
      t.text    :synchronous_commit
      t.text    :wal_writer_delay
      
      t.integer :commit_delay
      t.integer :commit_siblings, :limit => 2
      
      t.integer :wal_keep_segments, :limit => 2
      
      t.text    :geqo
      t.integer :geqo_threshold, :limit => 2
      t.integer :geqo_effort, :limit => 2
      t.integer :geqo_pool_size
      t.integer :geqo_generations
      t.decimal :geqo_selection_bias
      t.decimal :geqo_seed
      
      t.integer :default_statistics_target, :limit => 2
      t.text    :constraint_exclusion
      t.decimal :cursor_tuple_fraction
      
      t.integer :from_collapse_limit, :limit => 2
      t.integer :join_collapse_limit, :limit => 2
      
      t.text    :autovacuum
      t.integer :autovacuum_vacuum_threshold
      t.integer :autovacuum_analyze_threshold
      t.decimal :autovacuum_scale_factor
      t.decimal :autovacuum_analyze_scale_factor
      t.text    :autovacuum_vacuum_cost_delay
      
      t.text :deadlock_timeout
      
      t.timestamp :created_at, :null => false
    end
    
    execute "alter table transient_gucs alter column created_at set default now();"
  end
end
