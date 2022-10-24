class ProductSerializer < ActiveModel::Serializer
  attributes :id, :name, :price, :price_before_dicount, :discount, :shop, :image_url, :ratings, :rated_products, :return_policy, :shipping, :coupon_discount
end
