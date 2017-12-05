class RemoveControllerFromCartedProduct < ActiveRecord::Migration[5.1]
  def change
    remove_column :carted_products, :controller, :string
  end
end
