class CreateAlerts < ActiveRecord::Migration
  def change
    create_table :alerts do |t|

			t.text :query, :null => false
			t.text :label, :null => false
			t.text :message, :null => false, :default => 'This alert has been triggered.'

      t.timestamps
    end
  end
end
