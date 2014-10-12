class CreatePlots < ActiveRecord::Migration
  def change
    create_table :plots do |t|
			t.text :title, :null => false
			t.text :query, :null => false
			t.text :gnuplot_commands
			
			
			t.integer :position
			
			t.integer :width
			t.integer :height
      t.timestamps
    end
  end
end
