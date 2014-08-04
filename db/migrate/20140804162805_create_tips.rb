class CreateTips < ActiveRecord::Migration
  def change
    create_table :tips do |t|
      t.integer :user_id
      t.integer :recipient_id
      t.string :link

      t.timestamps
    end
  end
end
