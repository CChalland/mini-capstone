class CreateImages < ActiveRecord::Migration[5.1]
  def change
    create_table :images do |t|
      t.string :url1
      t.string :url2
      t.string :url3

      t.timestamps
    end
  end
end
