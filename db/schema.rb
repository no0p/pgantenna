# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20141012000725) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "plotpg"

  create_table "alert_emails", force: true do |t|
    t.text     "email",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "alerts", force: true do |t|
    t.text     "query",                                                 null: false
    t.text     "label",                                                 null: false
    t.text     "message",    default: "This alert has been triggered.", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "boxes", force: true do |t|
    t.text     "query",                    null: false
    t.text     "label",                    null: false
    t.integer  "position",   default: 100, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "columns", force: true do |t|
    t.integer  "table_id",      null: false
    t.text     "name",          null: false
    t.text     "data_type",     null: false
    t.boolean  "attnotnull",    null: false
    t.integer  "attstattarget", null: false
    t.integer  "attnum",        null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "connection_infos", force: true do |t|
    t.text     "ip",              null: false
    t.text     "hostname"
    t.datetime "connected_at",    null: false
    t.datetime "disconnected_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "databases", force: true do |t|
    t.text     "name",                               null: false
    t.integer  "connection_limit"
    t.integer  "frozenxid"
    t.datetime "created_at",       default: "now()"
    t.datetime "updated_at"
  end

  create_table "filesystems", force: true do |t|
    t.text     "name",                         null: false
    t.text     "mnt_dir",                      null: false
    t.text     "mnt_type",                     null: false
    t.text     "mnt_opts",                     null: false
    t.integer  "blksize",                      null: false
    t.integer  "fragsize",                     null: false
    t.datetime "created_at", default: "now()"
    t.datetime "updated_at"
  end

  create_table "functions", force: true do |t|
    t.integer  "database_id",                   null: false
    t.text     "schema_name",                   null: false
    t.integer  "funcoid",                       null: false
    t.text     "name",                          null: false
    t.datetime "created_at",  default: "now()"
    t.datetime "updated_at"
  end

  create_table "heartbeats", force: true do |t|
    t.integer  "current_tx_id", null: false
    t.datetime "measured_at",   null: false
  end

  add_index "heartbeats", ["measured_at"], name: "index_heartbeats_on_measured_at", using: :btree

  create_table "indices", force: true do |t|
    t.integer  "database_id",                   null: false
    t.integer  "table_id"
    t.text     "schema_name",                   null: false
    t.text     "name",                          null: false
    t.integer  "index_oid",                     null: false
    t.text     "relam"
    t.integer  "indnatts"
    t.text     "indkey"
    t.boolean  "indisunique"
    t.datetime "created_at",  default: "now()"
    t.datetime "updated_at"
  end

  add_index "indices", ["database_id", "schema_name", "name"], name: "index_indices_on_database_id_and_schema_name_and_name", unique: true, using: :btree

  create_table "notifications", force: true do |t|
    t.integer  "alert_id",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "plots", force: true do |t|
    t.text     "title",            null: false
    t.text     "query",            null: false
    t.text     "gnuplot_commands"
    t.integer  "position"
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "restart_gucs", force: true do |t|
    t.decimal  "shared_buffers"
    t.integer  "max_connections"
    t.integer  "blk_size"
    t.text     "listen_addresses"
    t.text     "wal_level"
    t.integer  "wal_buffers"
    t.integer  "max_wal_senders",                     limit: 2
    t.integer  "autovacuum_max_workers",              limit: 2
    t.decimal  "autovacuum_freeze_max_age"
    t.decimal  "autovacuum_multixact_freeze_max_age"
    t.integer  "max_locks_per_transaction",           limit: 2
    t.integer  "max_pred_locks_per_transaction",      limit: 2
    t.integer  "wal_segment_size"
    t.text     "data_directory"
    t.datetime "created_at",                                    default: "now()", null: false
  end

  create_table "settings", force: true do |t|
    t.text     "access_token"
    t.text     "access_token_digest"
    t.text     "ses_secret_key"
    t.text     "ses_access_key"
    t.text     "ses_from_email"
    t.integer  "repeat_notification_after_seconds", default: 600, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "stat_activity", force: true do |t|
    t.integer  "database_id",      null: false
    t.integer  "pid",              null: false
    t.text     "user",             null: false
    t.text     "application_name"
    t.text     "client_addr",      null: false
    t.text     "state",            null: false
    t.text     "query"
    t.datetime "backend_start"
    t.datetime "query_start"
    t.datetime "state_change"
    t.datetime "measured_at",      null: false
  end

  create_table "stat_bgwriter", force: true do |t|
    t.integer  "checkpoints_timed",     limit: 8, null: false
    t.integer  "checkpoints_req",       limit: 8, null: false
    t.decimal  "checkpoint_write_time",           null: false
    t.decimal  "checkpoint_sync_time",            null: false
    t.integer  "buffers_checkpoint",    limit: 8, null: false
    t.integer  "buffers_clean",         limit: 8, null: false
    t.integer  "maxwritten_clean",      limit: 8, null: false
    t.integer  "buffers_backend",       limit: 8, null: false
    t.integer  "buffers_backend_fsync", limit: 8, null: false
    t.integer  "buffers_alloc",         limit: 8, null: false
    t.datetime "stats_reset",                     null: false
    t.datetime "measured_at",                     null: false
  end

  create_table "stat_class", force: true do |t|
    t.integer  "table_id"
    t.integer  "index_id"
    t.integer  "relpages"
    t.integer  "reltuples"
    t.integer  "relallvisible"
    t.integer  "rel_size_bytes"
    t.integer  "rel_indexes_size_bytes"
    t.datetime "measured_at",            null: false
  end

  add_index "stat_class", ["index_id", "measured_at"], name: "index_stat_class_on_index_id_and_measured_at", using: :btree
  add_index "stat_class", ["table_id", "measured_at"], name: "index_stat_class_on_table_id_and_measured_at", using: :btree

  create_table "stat_column", force: true do |t|
    t.integer  "column_id",           null: false
    t.decimal  "null_fraction"
    t.integer  "average_width_bytes"
    t.decimal  "distinct_non_nulls"
    t.text     "most_common_vals"
    t.text     "most_common_freqs"
    t.decimal  "correlation"
    t.datetime "measured_at",         null: false
  end

  create_table "stat_database", force: true do |t|
    t.integer  "database_id",                                null: false
    t.integer  "numbackends",                                null: false
    t.integer  "xact_commit",    limit: 8,                   null: false
    t.integer  "xact_rollback",  limit: 8,                   null: false
    t.integer  "blks_read",      limit: 8,                   null: false
    t.integer  "blks_hit",       limit: 8,                   null: false
    t.integer  "tup_returned",   limit: 8,                   null: false
    t.integer  "tup_fetched",    limit: 8,                   null: false
    t.integer  "tup_inserted",   limit: 8,                   null: false
    t.integer  "tup_updated",    limit: 8,                   null: false
    t.integer  "tup_deleted",    limit: 8,                   null: false
    t.integer  "conflicts",      limit: 8,                   null: false
    t.integer  "temp_files",     limit: 8,                   null: false
    t.integer  "temp_bytes",     limit: 8,                   null: false
    t.integer  "deadlocks",      limit: 8,                   null: false
    t.float    "blk_read_time",                              null: false
    t.float    "blk_write_time",                             null: false
    t.datetime "stats_reset"
    t.datetime "measured_at",                                null: false
    t.datetime "created_at",               default: "now()", null: false
  end

  add_index "stat_database", ["database_id", "measured_at"], name: "index_stat_database_on_database_id_and_measured_at", using: :btree

  create_table "stat_filesystems", force: true do |t|
    t.integer  "filesystem_id",                             null: false
    t.integer  "blks_in_frags", limit: 8,                   null: false
    t.integer  "blk_free",      limit: 8,                   null: false
    t.integer  "blk_avail",     limit: 8,                   null: false
    t.datetime "measured_at",             default: "now()", null: false
  end

  create_table "stat_lock", force: true do |t|
    t.integer  "database_id",      null: false
    t.integer  "stat_activity_id", null: false
    t.boolean  "granted",          null: false
    t.text     "holder_vxid",      null: false
    t.text     "lock_type",        null: false
    t.text     "lock_mode",        null: false
    t.integer  "table_id"
    t.integer  "relation_oid"
    t.integer  "page"
    t.integer  "tuple"
    t.integer  "transaction_id"
    t.text     "vtransaction_id"
    t.datetime "measured_at",      null: false
  end

  create_table "stat_replication", force: true do |t|
    t.text     "usename",          null: false
    t.text     "application_name"
    t.text     "client_addr",      null: false
    t.text     "client_hostname"
    t.text     "null"
    t.text     "client_port",      null: false
    t.datetime "backend_start",    null: false
    t.text     "state",            null: false
    t.text     "sent_location",    null: false
    t.text     "write_location",   null: false
    t.text     "flush_location",   null: false
    t.text     "replay_location",  null: false
    t.text     "sync_priority",    null: false
    t.text     "sync_state",       null: false
    t.text     "current_xlog",     null: false
    t.datetime "measured_at",      null: false
  end

  create_table "stat_statements", force: true do |t|
    t.integer  "statement_id",                                    null: false
    t.integer  "role_oid",                                        null: false
    t.integer  "db_oid",                                          null: false
    t.integer  "calls",               limit: 8,                   null: false
    t.decimal  "total_time",                                      null: false
    t.integer  "rows",                limit: 8,                   null: false
    t.integer  "shared_blks_hit",     limit: 8,                   null: false
    t.integer  "shared_blks_read",    limit: 8,                   null: false
    t.integer  "shared_blks_dirtied", limit: 8,                   null: false
    t.integer  "shared_blks_written", limit: 8,                   null: false
    t.integer  "local_blks_hit",      limit: 8,                   null: false
    t.integer  "local_blks_read",     limit: 8,                   null: false
    t.integer  "local_blks_dirtied",  limit: 8,                   null: false
    t.integer  "local_blks_written",  limit: 8,                   null: false
    t.integer  "temp_blks_read",      limit: 8,                   null: false
    t.integer  "temp_blks_written",   limit: 8,                   null: false
    t.decimal  "blk_read_time",                                   null: false
    t.decimal  "blk_write_time",                                  null: false
    t.datetime "measured_at",                                     null: false
    t.datetime "created_at",                    default: "now()", null: false
  end

  create_table "stat_systems", force: true do |t|
    t.integer  "cpu_count",                                    null: false
    t.integer  "page_size",                                    null: false
    t.integer  "pages",            limit: 8,                   null: false
    t.integer  "pages_available",  limit: 8,                   null: false
    t.decimal  "one_min_load_avg",                             null: false
    t.integer  "swap_total",       limit: 8,                   null: false
    t.integer  "swap_free",        limit: 8,                   null: false
    t.integer  "swap_cached",      limit: 8,                   null: false
    t.integer  "page_cache",       limit: 8,                   null: false
    t.integer  "buffer_cache",     limit: 8,                   null: false
    t.datetime "measured_at",                default: "now()", null: false
  end

  create_table "stat_user_functions", force: true do |t|
    t.integer  "function_id",           null: false
    t.integer  "calls",       limit: 8, null: false
    t.decimal  "total_time",            null: false
    t.decimal  "self_time",             null: false
    t.datetime "measured_at",           null: false
  end

  add_index "stat_user_functions", ["function_id", "measured_at"], name: "index_stat_user_functions_on_function_id_and_measured_at", unique: true, using: :btree

  create_table "stat_user_indexes", force: true do |t|
    t.integer  "index_id",                null: false
    t.integer  "idx_scan",      limit: 8, null: false
    t.integer  "idx_tup_read",  limit: 8, null: false
    t.integer  "idx_tup_fetch", limit: 8, null: false
    t.datetime "measured_at",             null: false
  end

  add_index "stat_user_indexes", ["index_id", "measured_at"], name: "index_stat_user_indexes_on_index_id_and_measured_at", unique: true, using: :btree

  create_table "stat_user_tables", force: true do |t|
    t.integer  "table_id",                    null: false
    t.integer  "seq_scan",          limit: 8, null: false
    t.integer  "seq_tup_read",      limit: 8, null: false
    t.integer  "idx_scan",          limit: 8, null: false
    t.integer  "idx_tup_fetch",     limit: 8, null: false
    t.integer  "n_tup_ins",         limit: 8, null: false
    t.integer  "n_tup_upd",         limit: 8, null: false
    t.integer  "n_tup_del",         limit: 8, null: false
    t.integer  "n_tup_hot_upd",     limit: 8, null: false
    t.integer  "n_live_tup",        limit: 8, null: false
    t.integer  "n_dead_tup",        limit: 8, null: false
    t.integer  "vacuum_count",      limit: 8, null: false
    t.integer  "autovacuum_count",  limit: 8, null: false
    t.integer  "analyze_count",     limit: 8, null: false
    t.integer  "autoanalyze_count", limit: 8, null: false
    t.datetime "last_vacuum"
    t.datetime "last_autovacuum"
    t.datetime "last_analyze"
    t.datetime "last_autoanalyze"
    t.datetime "measured_at",                 null: false
  end

  add_index "stat_user_tables", ["table_id", "measured_at"], name: "index_stat_user_tables_on_table_id_and_measured_at", unique: true, using: :btree

  create_table "statements", force: true do |t|
    t.text     "q",                            null: false
    t.text     "query_hash",                   null: false
    t.datetime "created_at", default: "now()"
  end

  add_index "statements", ["query_hash"], name: "index_statements_on_query_hash", unique: true, using: :btree

  create_table "statio_user_indexes", force: true do |t|
    t.integer  "index_id",                null: false
    t.integer  "idx_blks_read", limit: 8, null: false
    t.integer  "idx_blks_hit",  limit: 8, null: false
    t.datetime "measured_at",             null: false
  end

  add_index "statio_user_indexes", ["index_id", "measured_at"], name: "index_statio_user_indexes_on_index_id_and_measured_at", unique: true, using: :btree

  create_table "statio_user_tables", force: true do |t|
    t.integer  "table_id",                  null: false
    t.integer  "heap_blks_read",  limit: 8, null: false
    t.integer  "heap_blks_hit",   limit: 8, null: false
    t.integer  "idx_blks_read",   limit: 8, null: false
    t.integer  "idx_blks_hit",    limit: 8, null: false
    t.integer  "toast_blks_read", limit: 8, null: false
    t.integer  "toast_blks_hit",  limit: 8, null: false
    t.integer  "tidx_blks_read",  limit: 8, null: false
    t.integer  "tidx_blks_hit",   limit: 8, null: false
    t.datetime "measured_at",               null: false
  end

  add_index "statio_user_tables", ["table_id", "measured_at"], name: "index_statio_user_tables_on_table_id_and_measured_at", unique: true, using: :btree

  create_table "tables", force: true do |t|
    t.integer  "database_id",                      null: false
    t.text     "schema_name",                      null: false
    t.text     "name",                             null: false
    t.integer  "table_oid",                        null: false
    t.integer  "relchecks"
    t.boolean  "relhaspkey"
    t.boolean  "relhastriggers"
    t.text     "relpersistence"
    t.datetime "created_at",     default: "now()"
    t.datetime "updated_at"
  end

  create_table "transient_gucs", force: true do |t|
    t.integer  "checkpoint_segments",             limit: 2
    t.integer  "checkpoint_timeout"
    t.decimal  "checkpoint_completion_target"
    t.integer  "work_mem"
    t.integer  "temp_buffers"
    t.integer  "maintenance_work_mem"
    t.decimal  "seq_page_cost"
    t.decimal  "random_page_cost"
    t.decimal  "cpu_tuple_cost"
    t.decimal  "cpu_operator_cost"
    t.integer  "effective_cache_size"
    t.integer  "vacuum_cost_delay"
    t.integer  "vacuum_cost_page_hit"
    t.integer  "vacuum_cost_page_miss"
    t.integer  "vacuum_cost_page_dirty"
    t.integer  "vacuum_cost_limit"
    t.text     "bgwriter_delay"
    t.integer  "bgwriter_lru_maxpages",           limit: 2
    t.decimal  "bgwriter_lru_multiplier"
    t.integer  "effective_io_concurrency",        limit: 2
    t.text     "synchronous_commit"
    t.text     "wal_writer_delay"
    t.integer  "commit_delay"
    t.integer  "commit_siblings",                 limit: 2
    t.integer  "wal_keep_segments",               limit: 2
    t.text     "geqo"
    t.integer  "geqo_threshold",                  limit: 2
    t.integer  "geqo_effort",                     limit: 2
    t.integer  "geqo_pool_size"
    t.integer  "geqo_generations"
    t.decimal  "geqo_selection_bias"
    t.decimal  "geqo_seed"
    t.integer  "default_statistics_target",       limit: 2
    t.text     "constraint_exclusion"
    t.decimal  "cursor_tuple_fraction"
    t.integer  "from_collapse_limit",             limit: 2
    t.integer  "join_collapse_limit",             limit: 2
    t.text     "autovacuum"
    t.integer  "autovacuum_vacuum_threshold"
    t.integer  "autovacuum_analyze_threshold"
    t.decimal  "autovacuum_scale_factor"
    t.decimal  "autovacuum_analyze_scale_factor"
    t.text     "autovacuum_vacuum_cost_delay"
    t.text     "deadlock_timeout"
    t.datetime "created_at",                                default: "now()", null: false
  end

end
