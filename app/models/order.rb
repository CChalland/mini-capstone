class Order < ApplicationRecord

  belongs_to :user, optional: true
  belongs_to :product

  # def user_id
  #   user.id
  # end

  def subtotal
    product.price * quantity
  end

  def tax
    subtotal * 0.09
  end

  def total
    subtotal + tax
  end

  # def as_json
  #   {
  #     id: id,
  #     product_id: product_id
  #     quantity: quantity,
  #     sub_total: sub_total,
  #     tax: tax,
  #     total: total,
  #     updated_at: updated_at
  #   }
  # end

end
