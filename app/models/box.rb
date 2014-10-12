class Box < ActiveRecord::Base

	validates_presence_of :query, :label

	#
	# Returns the first value from the query associated with the box.
	#
	def metric_value
		result = ActiveRecord::Base.connection.execute self.query
		return nil if result.blank? || result.first.blank? || result.first.keys.blank?
		return result.first[result.first.keys.first] # is there a better way to do this?
	end

end
