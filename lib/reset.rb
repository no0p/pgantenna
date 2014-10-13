Dir[File.dirname(__FILE__) + '/defaults/**/*.rb'].each {|file| require file }

module Reset

	# Calling this method deletes all plots and boxes, then populates the default boxes and plots
	def self.all!
		plots!
		boxes!
		alerts!
	end
	
	def self.plots!
		Plot.delete_all
		
		tx_sec_plot!
		connections_plot!
		memory_plot!
	end
	
	def self.boxes!
		Box.delete_all
		
		last_heartbeat_box!
		longest_transaction_box!
		system_load_box!
	end
	
	def self.alerts!
		Alert.delete_all
		
		deadman_switch!
		filesystem_free_space!
	end
	
end
