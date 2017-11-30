class Product < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: true
  validates :price, numericality: {greater_than: 0}
  validates :description, length: {in: 5..500} 
  
  has_many :orders
  belongs_to :supplier
  # def supplier
  #   Supplier.find_by(id: supplier_id)
  # end
  has_many :images
  # def images
  #   Image.find_by(id: self.image_id)
  # end

  def is_discounted
    price <= 2
  end

  def tax
    price * 0.09
  end

  def total
    price + tax
  end

  def as_json
    {
      id: id,
      name: name,
      description: description,
      image: images.map { |image| image.url},
      price: price,
      tax: tax,
      total: total,
      discounted: is_discounted,
      supplier: supplier.as_json,
    }
  end
end
