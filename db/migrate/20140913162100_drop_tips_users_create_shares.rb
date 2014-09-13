class DropTipsUsersCreateShares < ActiveRecord::Migration
  def change
  	drop_table :tips_users
	  create_table :shares do |t|
	    t.belongs_to :tip
	    t.belongs_to :user
	    t.boolean :visited
	    t.timestamps
    end
  end
end
