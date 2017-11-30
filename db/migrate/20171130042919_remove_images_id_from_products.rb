class RemoveImagesIdFromProducts < ActiveRecord::Migration[5.1]
  def change
    remove_column :products, :images_id, :integer
  end
end
