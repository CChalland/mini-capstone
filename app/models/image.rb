class Image < ApplicationRecord
  validates :url, presence: true
  validates :url, uniqueness: true

  belongs_to :product, optional: true 
end
