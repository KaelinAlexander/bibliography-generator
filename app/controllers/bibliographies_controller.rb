class BibliographiesController < ApplicationController
    before_action :require_login

    def show
        @bibliography = Bibliography.find(params[:id])
    end

    def index
        @user = User.find(params[:user_id])
        @bibliographies = Bibliography.find_by(user_id: params[:user_id])
    end

    def new
        @user = User.find(params[:user_id])
        @bibliography = @user.bibliographies.build
    end

    def create
        @user = User.find(session[:user_id])
        @bibliography = @user.bibliographies.build(bibliography_params)
        if @bibliography.save
            redirect_to user_bibliography_path(@bibliography)
        else
            render :new
        end
    end

    def edit
        @bibliography = Bibliography.find(params[:id])
    end

    def update
        @bibliography = Bibliography.find(params[:id])
        @bibliography.update(bibliography_params)
            redirect_to user_bibliography_path(@bibliography)
    end

    def style
        @bibliography = Bibliography.find(params[:id])
        @bibliography.style = params[:bibliography][:style]
        @bibliography.save
            render :show
    end

    def confirm
        @bibliography = Bibliography.find(params[:id])
    end

    def destroy
        Bibliography.find(params[:id]).destroy
        redirect_to user_bibliographies_path
    end

    def bibliography_params
        params.require(:bibliography).permit(:name, :style, :use)
    end

end