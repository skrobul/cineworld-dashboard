class CinemasController < ApplicationController
    respond_to :json

    def index
        @cinemas = Cinema.where(id: ObservedCinema.all.map(&:cinema_id))
        render json: @cinemas
    end
end
