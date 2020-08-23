require 'uri'

class TextsController < ApplicationController
    before_action :require_login

    def index
        @texts = Text.all
    end

    def show
        @text = Text.find(params[:id])
        @citation = @text.citations.build(:text_id => params[:id])
    end

    def new
        @text = Text.new
        @text.authors.build(:author_type => "author")
        @text.authors.build(:author_type => "editor")
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
        @text = Text.find(params[:id])
        @text.authors.destroy
        @text.destroy
        redirect_to texts_path
    end

    private
    def text_params
        params.require(:text).permit(:title, :subtitle, :publisher, :pub_year, :authors_attributes => [:first_name, :last_name, :author_type])
    end

end