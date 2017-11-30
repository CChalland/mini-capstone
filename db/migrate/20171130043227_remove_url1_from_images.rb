class RemoveUrl1FromImages < ActiveRecord::Migration[5.1]
  def change
    remove_column :images, :url1, :string
  end
end
