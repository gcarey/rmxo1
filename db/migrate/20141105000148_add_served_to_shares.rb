class AddServedToShares < ActiveRecord::Migration
  def change
    add_column :shares, :served, :boolean
  end
end
