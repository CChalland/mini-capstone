class Image < ApplicationRecord
  validates :url1, presence: true
  validates :url1, uniqueness: true
  validates :url2, presence: true
  validates :url2, uniqueness: true
  validates :url3, presence: true
  validates :url3, uniqueness: true

  belongs_to :product
  # def products
  #   Product.where(image_id: self.id)
  #   # Product.where(image_id: id)
  # end

  def as_json
    {
      id: id,
      url1: url1,
      url2: url2,
      url3: url3
    }
  end
end