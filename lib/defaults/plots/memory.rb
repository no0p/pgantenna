module Reset
	
	#
	# The query for the transaction / sec plot
	#
	def self.memory_plot!
	
	q = <<SQL
SELECT (total_memory - (free_memory + disk_cache + shared_buffers)) / total_memory::numeric as application_memory,
        free_memory / total_memory::numeric as free_memory,
        disk_cache / total_memory::numeric as disk_cache,
        shared_buffers / total_memory::numeric as shared_buffers
    FROM (SELECT pages * page_size as total_memory, 
                   pages_available * page_size as free_memory, 
                   page_cache * 1024 as disk_cache,
                   gucs.bufs as shared_buffers
              FROM stat_systems, 
                   ( SELECT shared_buffers * blk_size as bufs FROM restart_gucs ORDER BY created_at DESC LIMIT 1) as gucs
              ORDER BY measured_at DESC
              LIMIT 1
        ) as foo
SQL

	gcmds = <<GNU
set border lw 0;
GNU

		Plot.create(:title => 'Memory Usage',
								:query => q, 
								:gnuplot_commands => gcmds, 
								:height => 300, 
								:width => 50, 
								:position => 0)
	end
	
end
