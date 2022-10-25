class SearchesController < ApplicationController

    def create
        search=Search.create!(search_term: params[:search])
        render json: search.products, status: :ok
    end
end
