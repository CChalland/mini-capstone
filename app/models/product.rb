class Product < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: true
  validates :price, numericality: {greater_than: 0}
  validates :description, length: {in: 5..500} 
  
  belongs_to :supplier
  def supplier
    Supplier.find_by(id: self.supplier_id)
    # Supplier.find_by(id: supplier_id)
  end

  belongs_to :image
  # def image
  #   Image.find_by(id: self.image_id)
  # end

  # has_many :images
  # def images
  #   Image.where(product_id: self.id)
  # end

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
      images: image.as_json,
      # image: image.map { |index| index.url},
      description: description,
      discounted: is_discounted,
      tax: tax,
      total: total,
      availability: availability,
      supplier: supplier.as_json,
      created_at: created_at,
      updated_at: updated_at  
    }
  end
end
