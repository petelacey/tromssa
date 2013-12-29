class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    request.env[:current_user]
  end

  def current_club
    request.env[:current_club]
  end
end
