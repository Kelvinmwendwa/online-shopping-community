# frozen_string_literal: true

class ChangePriceBeforeDiscountInProducts < ActiveRecord::Migration[7.0]
  def change
    rename_column :products, :price_before_dicount, :price_before_discount
  end
end
