class SportsController < ApplicationController
  respond_to :json

  def index
    sports = ClubService.new(storage_engine, current_club).get_sports(params[:birth_date])
    @sports = sports.map { |sport| s = sport["sport"]["name"]; [s, s] }
    respond_with(@sports)
  end

end
