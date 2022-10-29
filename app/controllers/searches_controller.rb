class SearchesController < ApplicationController

    before_action :authorize, only:[:index]

    def create
        term=params[:search_term].downcase
        search=Search.find_by(search_term:term)

        if search && search.products.length ==0
            search.update(count: 1)
            search.crawl
        end

        search=Search.create(search_term: term) unless search

        UserSearch.create(user_id:current_user.id,search_id:search.id) if logged_in?
        
        render json: search.products, status: :ok
    end

    def trends
       render json: Search.all.order_by_count.limit(12)
    end


    def index
        render json: current_user.searches.uniq
    end
end
