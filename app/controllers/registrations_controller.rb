class RegistrationsController < ApplicationController
  respond_to :html

  def show
    @registration = get_registration(current_club, current_user)
  end

  def new
    if get_registration(current_club, current_user)
      redirect_to registration_path
    else
      @registration = Registration.new(guardian: {}, athlete: {})
    end
  end

  def create
    registration = Registration.new(params)
    @registration = reg_svc.register(registration, current_club, current_user)
    respond_with(@registration, location: registration_path)
  end

  protected

  def get_registration(club, user)
    @registration = reg_svc.retrieve(current_club, current_user)
  end

  def reg_svc
    @reg_svc ||= RegistrationService.new
  end
end
