class AddAvailablity < ActiveRecord::Migration[5.1]
  def change
    add_column :products, :availability, :boolean, default: true
  end
end
