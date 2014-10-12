module Reset
	def self.last_heartbeat_box!
		
		q = <<SQL
SELECT round(extract( epoch from  (current_timestamp - max(measured_at)))) as mx
	FROM heartbeats
		WHERE measured_at > now() - interval '4 hours'
SQL
	
		Box.create(:query => q, :label => 'Seconds since heartbeat', :position => 0)
	end
end
