module Reset
	
	#
	# The query for the transaction / sec plot
	#
	def self.tx_sec_plot!
	
	q = <<SQL
select measured_at as time, 
	(current_tx_id - coalesce(lag(current_tx_id, 1) over w, current_tx_id)) / extract( epoch from  (measured_at - lag(measured_at, 1) over w))::numeric as "transactions/sec"
	from heartbeats as h 
		where measured_at > now() - interval '4 hours'
		window w as (order by measured_at) 
	order by measured_at asc
	LIMIT 200;
SQL

	gcmds = <<GNU
		set style data lines;
		set xtics autofreq;
		set key off;
		set rmargin 8;
GNU

		Plot.create(:title => 'Transactions per Second',
								:query => q, 
								:gnuplot_commands => gcmds, 
								:height => 300, 
								:width => 100, 
								:position => 0)
	end
	
end
