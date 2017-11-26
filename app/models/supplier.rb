class Supplier < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: true

  def products
    Product.where(supplier_id: self.id)
    # Product.where(supplier_id: id)
  end

  def as_json
    {
      id: id,
      name: name,
      email: email,
      phone_number: phone_number
      # products: products.map {|product| product.name}
    }
  end
end
