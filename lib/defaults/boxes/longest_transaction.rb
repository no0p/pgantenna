module Reset
	def self.longest_transaction_box!
		
		q = <<SQL
WITH last_measure as (
	SELECT measured_at m_at 
		FROM stat_activity 
			INNER JOIN databases on databases.id = stat_activity.database_id
	ORDER BY measured_at DESC
	LIMIT 1
) 
SELECT * FROM (
	SELECT round(extract( epoch from max(measured_at - query_start))) as seconds_running
		FROM stat_activity
			INNER JOIN databases on databases.id = stat_activity.database_id
			INNER JOIN last_measure ON last_measure.m_at = stat_activity.measured_at
		WHERE state IN ('active', 'idle in transaction', 'idle in transaction (aborted)')
	UNION
	SELECT * FROM (VALUES (0)) as t(seconds_running)) as foo
ORDER BY seconds_running DESC nulls last
LIMIT 1
SQL
	
		Box.create(:query => q, :label => 'Longest Running Transaction', :position => 1)
	end
end
