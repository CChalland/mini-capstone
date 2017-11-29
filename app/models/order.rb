class Order < ApplicationRecord

  belongs_to :user, optional: true
  belongs_to :product

  def subtotal
    return (product.price * quantity)
  end

  def tax
    return (subtotal * 0.09)
  end

  def total
    return (subtotal + tax)
  end
end
