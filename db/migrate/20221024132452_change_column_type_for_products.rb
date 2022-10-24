class ChangeColumnTypeForProducts < ActiveRecord::Migration[7.0]
  def change
    change_column :products, :price, :string
    change_column :products, :discount, :string
    change_column :products, :ratings, :string
    change_column :products, :price_before_discount, :string
    change_column :products, :rated_products, :string
  end
end
