class ProgramsController < ApplicationController
  respond_to :json

  def index
    programs = ClubService.new(storage_engine, current_club).get_programs(params[:birth_date])
    @programs = ProgramsDecorator.new(programs)
    respond_with(@programs)
  end
end
