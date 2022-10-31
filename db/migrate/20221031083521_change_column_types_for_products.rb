class ChangeColumnTypesForProducts < ActiveRecord::Migration[7.0]
  def change
    remove_column :products, :rated_products
    add_column :products, :rated_products, :integer
  end
end
