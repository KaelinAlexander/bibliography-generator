class AuthorsController < ApplicationController

    def show
        @author = Author.find(params[:id])
    end

    def index
        if params[:text_id]
            @text = Text.find(params[:text_id])
            @authors = @text.authors
        else
            @authors = Author.all
        end
    end

    def new
        @text = User.find(params[:text_id])
        @author = @text.authors.build
    end

    def create
        @text = Text.find(params[:text_id])
        @author = @text.authors.build(author_params)
        if @author.save
            redirect_to text_path(@text)
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