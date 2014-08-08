class RemoveImagesFromTips < ActiveRecord::Migration
  def change
    remove_column :tips, :images
  end
end
