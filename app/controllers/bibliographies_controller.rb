class BibliographiesController < ApplicationController
    before_action :require_login

    def show
        @bibliography = Bibliography.find(params[:id])
    end

    def index
        @bibs = Bibliography.all
    end

    def new
        @bib = Bibliography.new
    end

    def create
        @user = User.find(session[:user_id])
        @bib = @user.bibliographies.build(bibliography_params)
        if @bib.save
            redirect_to bibliography_path(@bib)
        else
            render :new
        end
    end

    def edit
        @bib = Bibliography.find(params[:id])
    end

    def update
        @bib = Bibliography.find(params[:id])
        @bib.update(bibliography_params)
            redirect_to bibliography_path(@bib)
    end


    def confirm
        @bib = Bibliography.find(params[:id])
    end

    def destroy
        Bibliography.find(params[:id]).destroy
        redirect_to bibliographies_path
    end

    def bibliography_params
        params.require(:bibliography).permit(:name, :style, :use)
    end

end