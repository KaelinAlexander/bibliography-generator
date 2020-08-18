require 'uri'

class SearchController < ApplicationController

    def results
        @results = session[:search_results]
    end
    
    def new
    end

    def create
        query = search_params.to_h
        search = LibraryService.new
        search_results = search.get_results(query)
        if search_results != nil
            redirect_to results_path
        else
            redirect_to search_path
        end
    end 

    private

        def search_params
            params.require(:search).permit(:q, :title, :name)
        end

end