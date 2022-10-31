class AddIndicesToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products,:products_sold, :integer,default: 0
  end
end
