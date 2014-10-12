class CreateBoxes < ActiveRecord::Migration
  def change
    create_table :boxes do |t|

			t.text :query, :null => false
			t.text :label, :null => false
			
			t.integer	:position, :null => false, :default => 100

      t.timestamps
    end
  end
end
