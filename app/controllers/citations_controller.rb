class CitationsController < ApplicationController

    def index
        @citations = Citation.all
    end

    def show
        @citation = Citation.find(params[:id])
    end

    def new
        @citation = Citation.new
    end

    def create
        @citation = Citation.new(citation_params)
        if @citation.save
            redirect_to text_path(@citation.text)
        else
            render :new
        end
    end

    def edit
        @citation = Citation.find(params[:id])
        @citation.update(citation_params)
            redirect_to @citation
    end

    private

    def citation_params
        params.require(:citation).permit(:citation_location, :citation_type, :bibliography_id, :text_id)
    end

end