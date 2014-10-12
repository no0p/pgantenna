class CreateStatColumns < ActiveRecord::Migration
  def change
    create_table :stat_column do |t|
			t.references :column, :null => false
			
			t.decimal :null_fraction
			t.integer :average_width_bytes
			t.decimal :distinct_non_nulls
			
			t.text :most_common_vals
			t.text :most_common_freqs
			
			t.decimal :correlation
			
			t.timestamp :measured_at, :null => false
      t.timestamps
    end
  end
end
