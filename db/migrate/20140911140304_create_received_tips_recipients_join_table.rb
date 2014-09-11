class CreateReceivedTipsRecipientsJoinTable < ActiveRecord::Migration
  def change
  	  create_table :received_tips_recipients, id: false do |t|
      t.integer :received_tip_id
      t.integer :recipient_id
    end
  end
end
