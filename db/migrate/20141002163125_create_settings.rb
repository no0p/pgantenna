class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|

			t.text :access_token
			t.text :access_token_digest
			
			t.text :ses_secret_key
			t.text :ses_access_key
			t.text :ses_from_email
			
			t.integer :repeat_notification_after_seconds, :null => false, :default => 600

      t.timestamps
    end
  end
end
