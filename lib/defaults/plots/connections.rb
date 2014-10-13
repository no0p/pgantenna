module Reset
	
	#
	# The query for the transaction / sec plot
	#
	def self.connections_plot!
	
	q = <<SQL
SELECT measured_at as time, count(*) as connections
	FROM stat_activity
		INNER JOIN databases ON databases.id = stat_activity.database_id
	WHERE measured_at > now() - interval '4 hours'
	GROUP BY measured_at
	ORDER BY measured_at DESC
	LIMIT 30
SQL

	gcmds = <<GNU
set style data boxes;
set style fill solid;
set boxwidth 5;
set xtics autofreq;
set key off;
set rmargin 8;
set style line 1 lc rgb '#147b00';
set style increment user;
set yrange[0:]
GNU

		Plot.create(:title => 'Open Connections', 
								:query => q, 
								:gnuplot_commands => gcmds, 
								:height => 300, 
								:width => 50, 
								:position => 2)
	end
	
end
