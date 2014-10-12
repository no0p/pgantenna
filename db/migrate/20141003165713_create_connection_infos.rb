class CreateConnectionInfos < ActiveRecord::Migration
  def change
    create_table :connection_infos do |t|

			t.text :ip, :null => false
			t.text :hostname

			t.timestamp :connected_at, :null => false
			t.timestamp :disconnected_at
			
      t.timestamps
    end
  end
end
