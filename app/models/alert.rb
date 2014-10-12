class Alert < ActiveRecord::Base

	validates_presence_of :query, :label, :message

	#
	# Returns true when this alert should send out a notification.
	#   A notification should be sent when the first 
	#
	def trigger?
	
		# Check if we already notified on this alert more recently than 
		#   settings.repeat_notification_after_seconds
		
		return false if Notification.where("alert_id = ?", self.id)
																.where("created_at > ?", Time.now - Setting.first.repeat_notification_after_seconds.seconds)
																.first.present?
		
		# Check notification condition
		result = ActiveRecord::Base.connection.execute self.query
		
		return true if result.blank? || result.first.blank? || result.first.keys.blank? || result.first[result.first.keys.first].blank?
		return false
	end

end
