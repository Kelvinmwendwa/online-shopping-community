class AddProductUrl < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :product_url,:string
  end
end
