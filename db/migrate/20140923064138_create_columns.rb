class CreateColumns < ActiveRecord::Migration
  def change
    create_table :columns do |t|
			t.references :table, :null => false
			t.text 			 :name, :null => false
			t.text			 :data_type, :null => false		
			t.boolean    :attnotnull, :null => false
			t.integer    :attstattarget, :null => false
			t.integer    :attnum, :null => false
			t.timestamps
    end
    
  end
end
