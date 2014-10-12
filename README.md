== Introduction

pgantenna receives data from a postgresql cluster running pgsampler over a network connection.  pgantenna digests the data and provides a monitoring platform for the cluster.

== Installation

pgantenna can be installed directly or run as directly as a convenient Docker container.   

With Docker launching an instance straightforward:

```
docker run -p 24831:24831 -p 80:80 pgantenna
```

You can now direct your postgresql cluster to begin shipping statistics to pgantenna by installing and configuring pgsampler.


== Development

Run the following command from the project root:

```
docker build .
```

This will generate a docker image based on the current state of the pgantenna application.



== Table Mappings

select current_txid -> heartbeats

pg_stat_activity       -> stat_activity
pg_stat_database       -> stat_database
pg_stat_bgwriter       -> stat_bgwriter
pg_stat_user_tables    -> stat_user_tables
pg_stat_user_indexes   -> stat_user_indexes
pg_statio_user_indexes -> statio_user_indexes
pg_statio_user_tables  -> statio_user_tables
pg_stat_user_functions -> stat_user_functions
pg_stat_replication    -> stat_replication
pg_stat_statements   -> stat_statements, statements (only if installed)

pg_locks             -> stat_lock
pg_class						 -> stat_class
pg_stats             -> stat_column

Filesystem Data      -> stat_filesystems
System Data					 -> stat_systems
GUCs -> restart_gucs, transient_gucs
