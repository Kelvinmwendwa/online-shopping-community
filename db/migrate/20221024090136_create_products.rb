# frozen_string_literal: true

class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name
      t.integer :price
      t.integer :price_before_dicount
      t.integer :discount
      t.string :shop
      t.string :image_url
      t.integer :ratings
      t.integer :rated_products
      t.string :return_policy
      t.string :shipping
      t.string :coupon_discount
      t.datetime :expire_at
      t.integer :search_id

      t.timestamps
    end
  end
end
