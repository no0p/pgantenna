module Reset
	def self.system_load_box!
		
		q = <<SQL
			SELECT DISTINCT ON (measured_at)  one_min_load_avg, measured_at 
			  FROM stat_systems
			  	WHERE measured_at > now() - interval '4 hours'
			  	ORDER BY measured_at DESC, one_min_load_avg
			  LIMIT 1
SQL
	
		Box.create(:query => q, :label => 'System Load', :position => 2)
	end
end
