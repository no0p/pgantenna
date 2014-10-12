class CreateFilesystems < ActiveRecord::Migration
  def change
    create_table :filesystems do |t|
      t.text :name,  :null => false
      t.text :mnt_dir,  :null => false
      t.text :mnt_type, :null => false 
      t.text :mnt_opts, :null => false 
      
      t.integer :blksize,  :null => false
      t.integer :fragsize, :null => false
      t.timestamps
    end
    
    execute "alter table filesystems alter column created_at set default now();"
  end
end
