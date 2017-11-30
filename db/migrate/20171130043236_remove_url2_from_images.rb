class RemoveUrl2FromImages < ActiveRecord::Migration[5.1]
  def change
    remove_column :images, :url2, :string
  end
end
