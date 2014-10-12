class CreateFunctions < ActiveRecord::Migration
  def change
    create_table :functions do |t|
      t.references :database, :null => false
      t.text       :schema_name, :null => false
      t.integer :funcoid, :null => false
      t.text       :name, :null => false
      t.timestamps
    end
    
    execute "alter table functions alter column created_at set default now();"
  end
end
