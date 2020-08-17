require 'uri'

class TextsController < ApplicationController

    def index
        @texts = Text.all
    end

    def show
        @text = Text.find(params[:id])
    end

    def new
        @text = Text.new
    end

    def create
        @text = Text.new(text_params)
        search = LibraryService.new
        escaped_title = URI.escape(@text.title)
        @text.title = search.get_text_by_title(escaped_title)
        @text.subtitle = search.get_text_by_subtitle(escaped_title)
        if @text.save
            redirect_to @text
        else
            render "new"
        end
    end

    private
    def text_params
        params.require(:text).permit(:title, :subtitle)
    end

end