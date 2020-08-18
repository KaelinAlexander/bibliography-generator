class BibliographiesController < ApplicationController
    before_action :require_login

def show
    @bibliography = Bibliography.find(params[:id])
end

def index
    @bibliographies = Bibliography.all
end

def new
    @bibliography = Bibliography.new
end

def create
    @user = User.find(session[:user_id])
    @bib = @user.bibliographies.build(bibliography_params)
    if @bib.save
        redirect_to bibliography_path(@bib)
    else
        redirect_to new_bibliography_path
    end
end

    def bibliography_params
        params.require(:bibliography).permit(:name, :style, :use)
    end

end