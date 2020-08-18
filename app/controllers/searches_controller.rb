require 'uri'

class SearchesController < ApplicationController

    def show
        if params[:search]
            query = search_params.to_h
            @search = SearchService.new(query)
        end
    end 

    private

        def search_params
            params.require(:search).permit(:q, :title, :name)
        end

end