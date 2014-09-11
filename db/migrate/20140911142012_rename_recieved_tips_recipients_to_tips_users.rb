class RenameRecievedTipsRecipientsToTipsUsers < ActiveRecord::Migration
  def change
    rename_table :received_tips_recipients, :tips_users
    rename_column :tips_users, :received_tip_id, :tip_id
    rename_column :tips_users, :recipient_id, :user_id
  end
end
