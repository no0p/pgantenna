class CreateStatements < ActiveRecord::Migration
  def change
    create_table :statements do |t|
      t.text       :q, :null => false
      t.text       :query_hash, :null => false
      t.timestamp :created_at
    end
    
    execute "alter table statements alter column created_at set default now();"
    add_index :statements, [:query_hash], :unique => true
  end
end
