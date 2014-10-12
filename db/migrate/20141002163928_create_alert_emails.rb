class CreateAlertEmails < ActiveRecord::Migration
  def change
    create_table :alert_emails do |t|

			t.text :email, :null => false

      t.timestamps
    end
  end
end
