require 'uri'

class TextsController < ApplicationController

    def index
        @texts = Text.all
    end

    def show
        @text = Text.find(params[:id])
        @citation = @text.citations.build(:text_id => params[:id])
    end

    def new
        @text = Text.new
        @text.authors.build(:author_type => "Author")
        @text.authors.build(:author_type => "Editor")
        @text.authors.build(:author_type => "Translator")
    end

    def create
        @text = Text.new(text_params)
        if @text.save
            redirect_to @text
        else
            render :new
        end
    end

    def edit
        @text = Text.find(params[:id])
    end

    def update
        @text = Text.find(params[:id])
        @text.update(text_params)
            redirect_to text_path(@text)
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
        params.require(:text).permit(:title, :subtitle, :edition, :publisher, :pub_year, :authors_attributes => [:first_name, :last_name, :author_type])
    end

end