class Product < ApplicationRecord
  def is_discounted
    price <= 2
  end

  def tax
    return (price * 0.09)
  end

  def total
    return (price + tax)
  end

  def as_json
    {
      id: id,
      name: name,
      price: price,
      image: image,
      description: description,
      discounted: is_discounted,
      tax: tax,
      total: total,
      availability: availability,
      created_at: created_at,
      updated_at: updated_at  
    }
  end
end
