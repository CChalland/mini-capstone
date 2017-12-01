Product.destroy_all
Image.destroy_all
Supplier.destroy_all
User.destroy_all
Order.destroy_all
Category.destroy_all
CategoryProduct.destroy_all


Supplier.create(name: "BAUER", email: "sale@bauer.com", phone_number: "888-509-6875")
Supplier.create(name: "WARRIOR", email: "sale@warrior.com", phone_number: "800-9687845")

Product.create(
  supplier_id: 1, 
  name: "BAUER VAPOR 1X ICE SKATES - 2017 [SENIOR]",
  price: "949.99",
  description: "The 1X is constructed using Bauer’s lasted 3D Curv Composite with X-Rib pattern and Comfort Edge padding."
)
Image.create(
  url: "https://images.purehockey.com/img.aspx?pic_id=108888&pic_type=5",
  product_id: 1
)
Product.create(
  supplier_id: 1, 
  name: "BAUER SUPREME S190 HOCKEY SHIN GUARDS - 2017 [SENIOR]",
  price: "109.99",
  description: "The S190 Shin guard come complete with a thermoformed, ribbed shin cap to provide elite protection with expert mobility."
)
Image.create(
  url: "https://images.purehockey.com/img.aspx?itm_id=26681&div_id=41&pic_type=5&mtx_id=0",
  product_id: 2
)
Product.create(supplier_id: 1,
  name: "BAUER VAPOR 1X PLAYER PANTS [SENIOR]",
  price: "209.99",
  description: "Bauer Vapor 1X Sr. Hockey Pants is the ultimate in mobility, the 1X Pants from Bauer have seen some serious upgrades."
)
Image.create(
  url: "https://images.purehockey.com/img.aspx?pic_id=96099&pic_type=5",
  product_id: 3
)

Product.create(supplier_id: 1,
  name: "BAUER SUPREME S190 HOCKEY SHOULDER PADS - 2017 [SENIOR]",
  price: "129.99",
  description: "The Bauer Supreme S190 shoulder pads are Bauer's latest release in their Supreme line."
)
Image.create(
  url: "https://images.purehockey.com/img.aspx?itm_id=26707&div_id=41&pic_type=5&mtx_id=0",
  product_id: 4
)
Product.create(supplier_id: 1,
  name: "BAUER SUPREME 1S HOCKEY ELBOW PADS - 2017 [SENIOR]",
  price: "149.99",
  description: "Designed specifically for an anatomical fit, the S17 Supreme line from Bauer is engineered from the inside out, using specially placed material to provide the player with a comfortable, natural fit."
  )
Image.create(
  url: "https://images.purehockey.com/img.aspx?itm_id=26713&div_id=41&pic_type=5&mtx_id=0",
  product_id: 5
)
Product.create(supplier_id: 1,
  name: "BAUER SUPREME 1S HOCKEY GLOVES - 2017 [SENIOR]",
  price: "199.99",
  description: "The Bauer Supreme 1S Hockey Gloves are silky smooth and offer elite level protection."
)
Image.create(
  url: "https://www.purehockey.com/product/Supreme_1S_Hockey_Gloves_-_2017/itm/26731-41/?mtx_id=0",
  product_id: 6
)
Product.create(supplier_id: 2,
  name: "WARRIOR ALPHA QX3 GRIP COMPOSITE HOCKEY STICK [SENIOR]",
  price: "149.99",
  description: "The word alpha is typically used to describe dominance, and that's exactly what you're getting in this stick. The newest and most revolutionary feature of the QX Pro Stick is the Quick Strike technology."
)
Image.create(
  url: "https://images.purehockey.com/img.aspx?pic_id=107935&pic_type=5",
  product_id: 7
)

Category.create(name: "Da Body")
Category.create(name: "Everything else")
CategoryProduct.create(category_id: 2, product_id: 1)
CategoryProduct.create(category_id: 1, product_id: 1)
CategoryProduct.create(category_id: 1, product_id: 2)
CategoryProduct.create(category_id: 1, product_id: 3)
CategoryProduct.create(category_id: 1, product_id: 4)
CategoryProduct.create(category_id: 1, product_id: 5)
CategoryProduct.create(category_id: 2, product_id: 6)
CategoryProduct.create(category_id: 2, product_id: 7)
