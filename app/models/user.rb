class User < ApplicationRecord
  has_secure_password

  has_many :orders
  has_many :carted_products
  

  def as_json
    {
      id: id,
      user_name: user_name,
      admin: admin,
      created_at: created_at,
      updated_at: updated_at
    }
  end
end
