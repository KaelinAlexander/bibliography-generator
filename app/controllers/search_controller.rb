require 'uri'

class SearchController < ApplicationController

    def show
    end
    
    def new
    end

    def create
        search_hash = params[:search]
        query = search_hash.each {|k,v| search_hash[k] = URI.escape(v)}
        search = LibraryService.new
        @results = search.get_text_by_title(escaped_title)
        @text.subtitle = search.get_text_by_subtitle(escaped_title)
    end 

end