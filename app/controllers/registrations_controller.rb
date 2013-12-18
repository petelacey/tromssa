class RegistrationsController < ApplicationController
  respond_to :html

  def new
    @registration = Registration.new(guardian: {}, athlete: {})
  end

  def create
    guardian = Registration.new(params)
    @registration = ::CreateRegistration.new(guardian).register
    respond_with(@registration, location: registration_path)
  end
end
