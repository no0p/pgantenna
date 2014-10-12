class CreateStatFilesystems < ActiveRecord::Migration
  def change
    create_table :stat_filesystems do |t|
			t.references :filesystem, :null => false
      
      t.integer :blks_in_frags, :null => false, :limit => 8
      t.integer :blk_free, :null => false, :limit => 8
      t.integer :blk_avail, :null => false, :limit => 8
      
      t.timestamp :measured_at, :null => false
    end
    execute "alter table stat_filesystems alter column measured_at set default now();"
  end
end
