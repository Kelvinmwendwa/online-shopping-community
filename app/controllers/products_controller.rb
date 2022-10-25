class ProductsController < ApplicationController
    def show
        product=Product.find_by(id: params[:id])

        render json: product, status: :ok
    end
end
