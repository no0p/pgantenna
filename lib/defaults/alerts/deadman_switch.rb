module Reset
	def self.deadman_switch!
		
		q = <<SQL
SELECT measured_at as is_alive
	FROM heartbeats
		WHERE measured_at > (clock_timestamp() - interval '1 minute')
	LIMIT 1
SQL
	
		Alert.create(:query => q, 
								 :label => "Deadman's Switch Heartbeat", 
								 :message => 'No heartbeat packed has been received by pgantenna for 1 minute.')
	end
end
