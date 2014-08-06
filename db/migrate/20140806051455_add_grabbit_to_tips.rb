class AddGrabbitToTips < ActiveRecord::Migration
  def change
    add_column :tips, :title, :string
    add_column :tips, :description, :text
    add_column :tips, :images, :text
  end
end
