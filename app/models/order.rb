class Order < ApplicationRecord

  belongs_to :user         #, optional: true
  has_many :carted_products
  has_many :products, through: :carted_products
  

  # def subtotal
  #   return (product.price * quantity)
  # end
  # def tax
  #   return (subtotal * 0.09)
  # end
  # def total
  #   return (subtotal + tax)
  # end
  # def as_json
  #   {
  #     id: id, 
  #     user_id: user_id,
  #     product_id: product,
  #     quantity: quantity,
  #     subtotal: subtotal,
  #     tax: tax,
  #     total: total,
  #     created_at: created_at,
  #     updated_at: updated_at
  #   }
  # end
end
