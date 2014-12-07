class BuildUserInvites < ActiveRecord::Migration
  def change
    create_table :invitees do |t|
      t.string :email
      t.timestamps
    end
 
    create_table :invites do |t|
      t.belongs_to :user
      t.belongs_to :invitee
      t.timestamps
    end

    add_column :users, :invitations, :integer
  end
end
