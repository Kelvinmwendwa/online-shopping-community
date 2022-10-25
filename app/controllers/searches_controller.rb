class SearchesController < ApplicationController

    def create
        search=Search.find_by(search_term:params[:search_term])

        search=Search.create(search_term: params[:search_term]) unless search
        
        render json: search.products, status: :ok
    end
end
