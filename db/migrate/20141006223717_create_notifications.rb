class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
			t.references :alert, :null => false
      t.timestamps
    end
  end
end
