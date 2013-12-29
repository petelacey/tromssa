class RootController < ApplicationController
  respond_to :html

  def index
    reg_svc.retrieve(current_club, current_user)
    if not registration
      redirect_to new_registration_path
    end
  end

  protected

  def reg_svc
    @reg_svc ||= RegistrationService.new
  end

end
