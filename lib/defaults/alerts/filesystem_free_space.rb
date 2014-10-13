
module Reset
	def self.filesystem_free_space!
		
		q = <<SQL
WITH last_stats as (
				SELECT DISTINCT ON (filesystem_id) filesystem_id, measured_at, blk_avail, blks_in_frags
					FROM stat_filesystems
						ORDER BY filesystem_id, measured_at DESC
			)
SELECT filesystems.name
				FROM filesystems
					INNER JOIN last_stats ON last_stats.filesystem_id = filesystems.id
			  WHERE ((blk_avail * blksize) / (blks_in_frags * fragsize)::numeric) < 0.2
SQL
	
		Alert.create(:query => q, 
								 :label => "Filesystem Free Speace", 
								 :message => 'A filesystem has less than 20% free space.')
	end
end





