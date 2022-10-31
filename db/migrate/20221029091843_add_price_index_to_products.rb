# frozen_string_literal: true

class AddPriceIndexToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :price_index, :integer, default: 1
  end
end
