class RemoveRecipientIdFromTips < ActiveRecord::Migration
  def change
  	remove_column :tips, :recipient_id
  end
end
