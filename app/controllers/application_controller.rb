class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user
  helper_method :current_club
  helper_method :storage_engine

  def current_user
    request.env[:current_user]
  end

  def current_club
    request.env[:current_club]
  end

  before_action do
    @current_club = current_club
  end

  def storage_engine
    case Rails.env
    when "development"
      Tromssa::Storage::NeoStore.new
    when "test"
      Tromssa::Storage::NeoStore.new
    when "production"
      Tromssa::Storage::NeoStore.new
    end
  end
end
