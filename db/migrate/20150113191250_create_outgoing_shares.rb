class CreateOutgoingShares < ActiveRecord::Migration
  def change
    create_table :outgoing_shares do |t|
      t.belongs_to :tip
      t.belongs_to :invitee
	    t.boolean :visited
      t.timestamps
    end
  end
end
