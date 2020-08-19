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

    end

    private
    def text_params
        params.require(:text).permit(:title, :subtitle, :container, :editor, :translator, :edition, :publisher, :pub_state, :pub_city, :pub_year)
    end

end