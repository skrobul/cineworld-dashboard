class FilmsController < ApplicationController
    respond_to :json

    def index
        @films = Film.all
        respond_with @films
    end

    def show
        @film = Film.find(params[:id])
        respond_with @film
    end

    def update
        @film = Film.find(params[:id])
        if @film.update_attributes(params[:film])
            head :no_content
        else
            render json: @film.errors, status: :unprocessable_entity 
        end
    end
end
