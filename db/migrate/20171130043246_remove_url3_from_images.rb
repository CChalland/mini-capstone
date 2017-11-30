class RemoveUrl3FromImages < ActiveRecord::Migration[5.1]
  def change
    remove_column :images, :url3, :string
  end
end
