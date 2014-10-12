class Plot < ActiveRecord::Base

	validates_presence_of :query, :title, :width, :height

	CONTAINER_WIDTH = 1140

	def svg
	  
	  # 1140px style width of home display page.
	  #   kind of janky to relative sizes, waiting to see how this shakes out.
	  #
	  #  Consider: static height.
	  #    Consider: height px, width %
	  
	  width_pixels = ([self.width, 100].min / 100.0) * CONTAINER_WIDTH
	  
	  plot_query = PLOT_DEFAULTS
		plot_query += "set plotpg.terminal='svg size #{width_pixels}, #{self.height}';"
		plot_query += "select plot('#{self.query.gsub(/'/, "''")}'"
		if self.gnuplot_commands.present?
			gnuplot_cmds = "set title '#{self.title}';".gsub(/'/, "''")
			gnuplot_cmds += self.gnuplot_commands.gsub(/'/, "''")
			plot_query += ", '#{gnuplot_cmds}'"
		end
		plot_query += ")"
		
		plot = ActiveRecord::Base.connection.execute plot_query
		svg_string = plot.first["plot"]
		
		return svg_string
	end
	
	# This comment contains an example of a technique for adjusting the width of the svg
	#   returned from the query.  IT's still up in the air how to best handle forming
	#   the svg for the web.
	# x = Nokogiri::HTML(svg_string)		
	# x.xpath('//svg').first['width'] = "#{self.width.to_i}%"
	
	
	#
	# Execute the query and return tabular data
	#
	def data
	end
	
end
