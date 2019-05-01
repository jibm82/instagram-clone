# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :configured_permitted_parameters, if: :devise_controller?

  protected

  def configured_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update, keys: %i(name))
    devise_parameter_sanitizer.permit(:sign_up, keys: %i(name))
  end
end
