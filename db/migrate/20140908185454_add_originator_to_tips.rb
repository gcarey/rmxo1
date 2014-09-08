class AddOriginatorToTips < ActiveRecord::Migration
  def change
    add_column :tips, :originator_id, :integer
  end
end
