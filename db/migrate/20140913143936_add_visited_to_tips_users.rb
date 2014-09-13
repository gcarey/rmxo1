class AddVisitedToTipsUsers < ActiveRecord::Migration
  def change
    add_column :tips_users, :visited, :boolean
  end
end
