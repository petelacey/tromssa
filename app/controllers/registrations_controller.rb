class RegistrationsController < ApplicationController
  respond_to :html

  def show
    @registration = reg_svc.retrieve(current_user)
  end

  def new
    @registration = Registration.new(guardian: {}, athlete: {})
  end

  def create
    registration = Registration.new(params)
    @registration = reg_svc.register(registration, current_user)
    respond_with(@registration, location: registration_path)
  end

  protected

  def reg_svc
    @reg_svc ||= RegistrationService.new
  end
end
