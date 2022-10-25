class SearchesController < ApplicationController

    before_action :authorize, only:[:index]

    def create
        search=Search.find_by(search_term:params[:search_term])

        search=Search.create(search_term: params[:search_term]) unless search

        UserSearch.create(user_id:current_user.id,search_id:search.id) if logged_in?
        
        render json: search.products, status: :ok
    end

    def index
        render json: current_user.searches.uniq
    end
end
