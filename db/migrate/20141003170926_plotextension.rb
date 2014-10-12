class Plotextension < ActiveRecord::Migration
  def up
  	execute "create extension plotpg"
  end
  
  def down
  	execute "drop extension plotpg"
  end
end
