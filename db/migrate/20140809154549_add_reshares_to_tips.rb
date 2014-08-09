class AddResharesToTips < ActiveRecord::Migration
  def change
    add_column :tips, :reshares, :integer
  end
end
