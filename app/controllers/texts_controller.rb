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
        @text.authors.build(:author_type => "Author")
        @text.authors.build(:author_type => "Editor")
        @text.authors.build(:author_type => "Translator")
    end

    def create
        byebug
        @text = Text.new(text_params)
        if @text.save
            redirect_to @text
        else
            render :new
        end
    end

    def confirm
        @text = Text.find(params[:id])
    end

    def destroy
        Text.find(params[:id]).destroy
        redirect_to texts_path
    end

    private
    def text_params
        params.require(:text).permit(:title, :subtitle, :container, :editor, :translator, :edition, :publisher, :pub_state, :pub_city, :pub_year, :authors_attributes => [:first_name, :last_name, :author_type])
    end

end