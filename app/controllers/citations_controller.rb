class CitationsController < ApplicationController
    before_action :require_login
    
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
        @text = @citation.text
        if @citation.save
            redirect_to bibliography_path(@citation.bibliography)
        else
            redirect_to text_path(@text)
        end
    end

    def edit
        @citation = Citation.find(params[:id])
    end

    def update
        @citation = Citation.find(params[:id])
        @citation.update(citation_params)
        redirect_to bibliography_path(@citation.bibliography)
    end

    def destroy
        @citation = Citation.find(params[:id])
        @bibliography = @citation.bibliography
        @citation.destroy
        redirect_to bibliography_path(@bibliography)
    end

    private

    def citation_params
        params.require(:citation).permit(:citation_location, :citation_type, :bibliography_id, :text_id)
    end

end