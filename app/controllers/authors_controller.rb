class AuthorsController < ApplicationController

    def index
        @authors = Author.all
    end

    def show
        @author = Author.find(params[:id])
    end

    def new
        @author = Author.new
    end

    def create
        @author = Author.new(author_params)
        if @author.save
            redirect_to @author
        else
            render :new
        end
    end

    def edit
        @author = Author.find(params[:id])
    end

    def update
        @author = Author.find(params[:id])
        @author.update(author_params)
            redirect_to @author
    end

    def destroy
        @author = Author.find(params[:id])
        @text = @author.text
        @author.destroy unless @text.authors.count == 1
        redirect_to @text
    end

    private
    def author_params
        params.require(:author).permit(:first_name, :last_name, :author_type)
    end

end